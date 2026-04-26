import os
import requests
from dotenv import load_dotenv

load_dotenv()

FIGMA_TOKEN = os.getenv("FIGMA_ACCESS_TOKEN")
FIGMA_FILE_ID = os.getenv("FIGMA_FILE_ID")

HEADERS = {"X-Figma-Token": FIGMA_TOKEN}
BASE_URL = "https://api.figma.com/v1"

def get_figma_file_data():
    """Get all file data using the general File API"""
    url = f"{BASE_URL}/files/{FIGMA_FILE_ID}?depth=2"
    response = requests.get(url, headers=HEADERS)
    return response.json()

def parse_file_context(data):
    """Parse file data into structured context for the agent"""
    context = "=== FIGMA DESIGN CONTEXT ===\n\n"
    
    document = data.get("document", {})
    
    # Get design styles from file
    styles = data.get("styles", {})
    if styles:
        context += "DESIGN STYLES:\n"
        for style_id, style in styles.items():
            context += f"- [{style.get('styleType')}] {style.get('name')}\n"
        context += "\n"
    
    # Parse pages
    for page in document.get("children", []):
        page_name = page.get("name")
        
        if page_name == "Components":
            context += "COMPONENTS:\n"
            for component in page.get("children", []):
                comp_name = component.get("name")
                context += f"\n{comp_name}:\n"
                
                # Layout properties
                if "paddingLeft" in component:
                    context += f"  Padding: top={component.get('paddingTop')}, bottom={component.get('paddingBottom')}, left={component.get('paddingLeft')}, right={component.get('paddingRight')}\n"
                if "itemSpacing" in component:
                    context += f"  Gap: {component.get('itemSpacing')}\n"
                if "cornerRadius" in component:
                    context += f"  Corner Radius: {component.get('cornerRadius')}\n"
                
                # Children layers
                for child in component.get("children", []):
                    child_name = child.get("name")
                    child_type = child.get("type")
                    context += f"  - {child_name} ({child_type})"
                    
                    # Text properties
                    if child_type == "TEXT":
                        style = child.get("style", {})
                        if style.get("fontSize"):
                            context += f": {style.get('fontSize')}pt, weight={style.get('fontWeight')}, font={style.get('fontFamily')}"
                    
                    context += "\n"
        
        elif page_name == "Screens":
            context += "\nSCREENS:\n"
            for screen in page.get("children", []):
                context += f"  - {screen.get('name')}\n"
        
        elif page_name == "Design Systems":
            context += "\nDESIGN SYSTEMS:\n"
            for item in page.get("children", []):
                context += f"  - {item.get('name')}\n"

    return context

def get_figma_context_for_query():
    """Combine all Figma context into a single string for the agent"""
    data = get_figma_file_data()
    return parse_file_context(data)

if __name__ == "__main__":
    print(get_figma_context_for_query())