from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health():
    # Retorna un JSON con estado 200 (OK)
    return jsonify({
        "club": "Fluminense",
        "especialidad": "Arroz",
        "status": "healthy"
        }), 200

@app.route('/perfil')
def perfil():
    return jsonify({"user": "Ignacio"}), 200


if __name__ == '__main__':
    # El host 0.0.0.0 es clave para que Docker pueda acceder
    app.run(host='0.0.0.0', port=5000)
