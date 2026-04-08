import pytest
from app import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_health_check(client):
    res = client.get('/health')
    data = res.get_json()

    assert res.status_code == 200

    assert data['club'] == "Fluminense"
    assert data['status'] == "healthy"

def test_perfil(client):
    res = client.get('/perfil')
    assert res.status_code == 200
    assert res.get_json()["user"] == "Ignacio"

