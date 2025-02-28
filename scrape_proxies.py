import requests
from bs4 import BeautifulSoup
import os

def test_proxy(ip, port):
    """Test if a proxy is functional."""
    try:
        test_url = "http://httpbin.org/ip"
        proxies = {"http": f"http://{ip}:{port}", "https": f"http://{ip}:{port}"}
        response = requests.get(test_url, proxies=proxies, timeout=10)
        return response.status_code == 200
    except:
        return False

def scrape_proxies():
    """Scrape proxies from free-proxy-list.net."""
    proxies = []
    try:
        url = "https://free-proxy-list.net/"
        response = requests.get(url, timeout=15)
        soup = BeautifulSoup(response.text, "html.parser")
        table = soup.find("table", {"id": "proxylisttable"})
        
        for row in table.tbody.find_all("tr"):
            cols = row.find_all("td")
            if len(cols) >= 7:
                ip = cols[0].text.strip()
                port = cols[1].text.strip()
                if test_proxy(ip, port):
                    proxies.append(f"{ip}:{port}")
    except Exception as e:
        print(f"Scraping failed: {str(e)}")
    
    # Fallback: Add static proxies if scraping fails
    if not proxies:
        proxies.extend(["192.168.1.1:8080", "10.0.0.1:8080"])  # Replace with backup proxies
    
    # Write to file
    with open("/proxies.txt", "w") as f:
        f.write("\n".join(proxies))

if __name__ == "__main__":
    scrape_proxies()
