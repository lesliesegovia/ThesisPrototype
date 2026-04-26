import os
import requests
from dotenv import load_dotenv

load_dotenv()

FIGMA_TOKEN = os.getenv("FIGMA_ACCESS_TOKEN")
FIGMA_FILE_ID = os.getenv("FIGMA_FILE_ID")

HEADERS = {"X-Figma-Token": FIGMA_TOKEN}
BASE_URL = "https://api.figma.com/v1"

def get_figma_components():
    """Get all components from the Figma file"""
    url = f"{BASE_URL}/files/{FIGMA_FILE_ID}/components"
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    
    components = []
    for key, comp in data.get("meta", {}).get("components", {}).items():
        components.append({
            "name": comp.get("name"),
            "description": comp.get("description", ""),
            "key": key
        })
    return components

def get_figma_file_structure():
    """Get the page and frame structure of the Figma file"""
    url = f"{BASE_URL}/files/{FIGMA_FILE_ID}?depth=2"
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    
    structure = []
    for page in data.get("document", {}).get("children", []):
        page_info = {
            "page": page.get("name"),
            "frames": [child.get("name") for child in page.get("children", [])]
        }
        structure.append(page_info)
    return structure

def get_figma_context_for_query():
    """Combine components and structure into context string for the agent"""
    components = get_figma_components()
    structure = get_figma_file_structure()
    
    context = "=== FIGMA DESIGN CONTEXT ===\n\n"
    
    context += "COMPONENTS:\n"
    for comp in components:
        context += f"- {comp['name']}"
        if comp['description']:
            context += f": {comp['description']}"
        context += "\n"
    
    context += "\nFILE STRUCTURE (Pages and Screens):\n"
    for page in structure:
        context += f"\nPage: {page['page']}\n"
        for frame in page['frames']:
            context += f"  - {frame}\n"
    
    return context

if __name__ == "__main__":
    print(get_figma_context_for_query())