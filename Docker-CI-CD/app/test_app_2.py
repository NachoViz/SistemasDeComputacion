import pytest
# Cambiamos 'app' por 'app_v2' (o el nombre que le hayas puesto)
from app_2 import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_health_check(client):
    res = client.get('/health')
    data = res.get_json()
    assert res.status_code == 200
    # Asegúrate de que esto coincida con lo que escribiste en app_v2.py
    assert data['status'] == "healthy"

def test_perfil(client):
    res = client.get('/perfil')
    assert res.status_code == 200
