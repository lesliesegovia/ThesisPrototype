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

if __name__ == "__main__":
    query = "Does the current codebase support NewsCardPlus, or are new components required?"
    print(run_query(query))