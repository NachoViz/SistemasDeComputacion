from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    """
    Este endpoint devuelve el estado actual. 
    Se ajustó para que coincida con los datos que mostró tu error de Pytest.
    """
    return jsonify({
        "status": "healthy",
        "club": "River",
        "especialidad": "Arroz"
    }), 200

@app.route('/perfil', methods=['GET'])
def perfil():
    """
    Este endpoint faltaba (por eso el error 404). 
    Ahora devuelve un estado 200 OK.
    """
    return jsonify({
        "usuario": "Nacho",
        "rol": "Developer",
        "mensaje": "Perfil cargado exitosamente"
    }), 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
