import os
from pathlib import Path
from dotenv import load_dotenv
from sentence_transformers import SentenceTransformer
import chromadb

load_dotenv()

# Load embedding model
model = SentenceTransformer('all-MiniLM-L6-v2')

# Initialize Chroma
client = chromadb.PersistentClient(path="./chroma_db")
collection = client.get_or_create_collection("swift_codebase")

# Path to your Swift files
SWIFT_PATH = Path("../Prototype")

def ingest_swift_files():
    swift_files = list(SWIFT_PATH.rglob("*.swift"))
    print(f"Found {len(swift_files)} Swift files")
    
    for file_path in swift_files:
        content = file_path.read_text()
        filename = file_path.name
        
        embedding = model.encode(content).tolist()
        
        collection.upsert(
            ids=[filename],
            embeddings=[embedding],
            documents=[content],
            metadatas=[{
                "filename": filename, 
                "path": str(file_path),
                "type": "screen" if "View" in filename else "component"
            }]
        )
        print(f"Ingested: {filename}")
    
    print("Ingestion complete!")

if __name__ == "__main__":
    ingest_swift_files()