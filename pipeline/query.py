import os
from dotenv import load_dotenv
from sentence_transformers import SentenceTransformer
import chromadb
import anthropic
from figma_context import get_figma_context_for_query

load_dotenv()

model = SentenceTransformer('all-MiniLM-L6-v2')
client = chromadb.PersistentClient(path="./chroma_db")
collection = client.get_or_create_collection("swift_codebase")

claude = anthropic.Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))

def query_codebase(query: str, n_results: int = 3):
    query_embedding = model.encode(query).tolist()
    results = collection.query(
        query_embeddings=[query_embedding],
        n_results=n_results
    )
    return results["documents"][0], results["metadatas"][0]

def run_query(query: str):
    # Get codebase context via RAG
    docs, metadatas = query_codebase(query)
    code_context = ""
    for doc, meta in zip(docs, metadatas):
        code_context += f"\n\n--- {meta['filename']} ---\n{doc}"
    
    # Get Figma design context via REST API
    figma_context = get_figma_context_for_query()
    
    prompt = f"""You are an AI assistant helping bridge design and engineering workflows.

=== FIGMA DESIGN CONTEXT ===
{figma_context}

=== CODEBASE CONTEXT (relevant Swift files) ===
{code_context}

Based on both the Figma design context and the codebase context above, answer the following question:
{query}"""
    
    response = claude.messages.create(
        model="claude-sonnet-4-5",
        max_tokens=1000,
        messages=[{"role": "user", "content": prompt}]
    )
    return response.content[0].text

# Queries to run
if __name__ == "__main__":
    queries = [
        # Design Completeness
        ("Q1", "Design Completeness", "Engineer", "Component", 
         "Are there any screens defined in the Figma design that do not have a corresponding implementation in the codebase?"),
        ("Q2", "Design Completeness", "Designer", "Detail", 
         "As a designer, are there existing components in the codebase I can reference before finalizing the NewsCardPlus design specs?"),
        ("Q3", "Design Completeness", "Engineer", "Component+Detail", 
         "The Figma design includes both a TechFeedView screen and a NewsCardPlus component. Do either of these exist in the current codebase?"),
        ("Q4", "Design Completeness", "Both", "Edge Case", 
         "Are there any design elements in the Figma file that engineering would need to implement but are not explicitly detailed enough to build from?"),
        
        # Feasibility Assessment
        ("Q5", "Feasibility Assessment", "Engineer", "Component", 
         "Can the TechFeedView screen be built using components that already exist in the codebase?"),
        ("Q6", "Feasibility Assessment", "Designer", "Detail", 
         "As a designer, what technical constraints in the current codebase should I be aware of before finalizing the NewsCardPlus design?"),
        ("Q7", "Feasibility Assessment", "Engineer", "Component+Detail", 
         "How much of the NewsCardPlus design can be implemented by reusing NewsCardCompact, and what would need to be built from scratch?"),
        ("Q8", "Feasibility Assessment", "Both", "Component+Detail", 
         "What is the simplest path to implement the new designs without adding unnecessary complexity to the codebase?"),
        
        # Design-to-Code Alignment
        ("Q9", "Design-to-Code Alignment", "Engineer", "Component", 
         "Does the CategoryFilterBar component in the codebase match its structure as defined in Figma?"),
        ("Q10", "Design-to-Code Alignment", "Designer", "Detail", 
         "Do the typography and color styles I defined in Figma match what has already been implemented in the codebase?"),
        ("Q11", "Design-to-Code Alignment", "Both", "Edge Case", 
         "The CategoryPill component has Selected and Unselected states in Figma. Are there any edge cases such as long text or missing state handling that exist in the design but aren't accounted for in the codebase?"),
        ("Q12", "Design-to-Code Alignment", "Both", "Technical Constraint", 
         "Does the current codebase architecture support the layout requirements of the TechFeedView screen as designed in Figma?"),
    ]

    # Save results to file
    with open("results.txt", "w") as f:
        for q_id, category, perspective, level, query in queries:
            print(f"\nRunning {q_id}...")
            response = run_query(query)
            
            output = f"""
{'='*60}
{q_id} | {category} | {perspective} | {level}
QUERY: {query}
RESPONSE:
{response}
            """
            print(output)
            f.write(output)
    
    print("\n queries complete! Results saved to results.txt")