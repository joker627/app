from flask import Flask, request, jsonify
import pymysql
from flask_cors import CORS

# =========================================================
# CONFIGURACIÓN INICIAL
# =========================================================
app = Flask(__name__)
CORS(app)

def connect_to_db():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='manueldev.55',
        database='consultorio_medico',
        cursorclass=pymysql.cursors.DictCursor,
        ssl_disabled=True
    )

# =========================================================
# RUTA RAÍZ
# =========================================================
@app.route('/', methods=['GET'])
def index():
    return jsonify({
        "status": "success",
        "message": "Bienvenido a la API del consultorio médico",
        "endpoints": [
            "/api/pacientes",
            "/api/medicos",
            "/api/consultorios",
            "/api/tratamientos",
            "/api/citas"
        ]
    })

# =========================================================
# PACIENTES (GET, POST)
# =========================================================
@app.route('/api/pacientes', methods=['GET', 'POST'])
def api_pacientes():
    try:
        conn = connect_to_db()
        cur = conn.cursor()

        if request.method == 'POST':
            data = request.get_json()
            if not data:
                return jsonify({"status": "error", "message": "No se recibieron datos JSON"}), 400
        elif request.args:
            data = {
                "PacIdentificacion": request.args.get('id'),
                "PacNombres": request.args.get('nombre'),
                "PacApellidos": request.args.get('apellido'),
                "PacFechaNacimiento": request.args.get('fecha'),
                "PacSexo": request.args.get('sexo')
            }
            if not all(data.values()):
                return jsonify({
                    "status": "error",
                    "message": "Faltan datos: id, nombre, apellido, fecha, sexo."
                }), 400
        else:
            cur.execute("SELECT * FROM pacientes")
            data = cur.fetchall()
            return jsonify({"status": "success", "pacientes": data})

        cur.execute("""
            INSERT INTO pacientes (PacIdentificacion, PacNombres, PacApellidos, PacFechaNacimiento, PacSexo)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            data['PacIdentificacion'], data['PacNombres'], data['PacApellidos'],
            data['PacFechaNacimiento'], data['PacSexo']
        ))
        conn.commit()

        return jsonify({"status": "success", "message": "Paciente registrado correctamente"})

    except Exception as e:
        print("❌ Error:", e)
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cur.close()
        conn.close()

# =========================================================
# PACIENTES: PUT / DELETE
# =========================================================
@app.route('/api/pacientes/<int:id>', methods=['PUT'])
def api_actualizar_paciente(id):
    data = request.get_json()
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        cur.execute("""
            UPDATE pacientes 
            SET PacIdentificacion=%s, PacNombres=%s, PacApellidos=%s, PacFechaNacimiento=%s, PacSexo=%s
            WHERE PacIdentificacion=%s
        """, (
            data['PacIdentificacion'], data['PacNombres'], data['PacApellidos'],
            data['PacFechaNacimiento'], data['PacSexo'], id
        ))
        conn.commit()
        return jsonify({"status": "success", "message": "Paciente actualizado correctamente"})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cur.close()
        conn.close()

@app.route('/api/pacientes/<int:id>', methods=['DELETE'])
def api_eliminar_paciente(id):
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        cur.execute("DELETE FROM pacientes WHERE PacIdentificacion=%s", (id,))
        conn.commit()
        return jsonify({"status": "success", "message": "Paciente eliminado correctamente"})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cur.close()
        conn.close()

# =========================================================
# MÉDICOS
# =========================================================
@app.route('/api/medicos', methods=['GET', 'POST'])
def api_medicos():
    try:
        conn = connect_to_db()
        cur = conn.cursor()

        if request.method == 'POST':
            data = request.get_json()
            cur.execute("""
                INSERT INTO medicos (MedIdentificacion, MedNombres, MedApellidos)
                VALUES (%s, %s, %s)
            """, (
                data['MedIdentificacion'], data['MedNombres'], data['MedApellidos']
            ))
            conn.commit()
            return jsonify({"status": "success", "message": "Médico registrado correctamente"})
        else:
            cur.execute("SELECT * FROM medicos")
            data = cur.fetchall()
            return jsonify({"status": "success", "medicos": data})

    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cur.close()
        conn.close()

@app.route('/api/medicos/<int:id>', methods=['PUT', 'DELETE'])
def api_modificar_medico(id):
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        if request.method == 'PUT':
            data = request.get_json()
            cur.execute("""
                UPDATE medicos 
                SET MedIdentificacion=%s, MedNombres=%s, MedApellidos=%s
                WHERE MedIdentificacion=%s
            """, (
                data['MedIdentificacion'], data['MedNombres'], data['MedApellidos'], id
            ))
            conn.commit()
            return jsonify({"status": "success", "message": "Médico actualizado correctamente"})
        else:
            cur.execute("DELETE FROM medicos WHERE MedIdentificacion=%s", (id,))
            conn.commit()
            return jsonify({"status": "success", "message": "Médico eliminado correctamente"})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cur.close()
        conn.close()

# =========================================================
# CONSULTORIOS
# =========================================================
@app.route('/api/consultorios', methods=['GET'])
def api_consultorios():
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        cur.execute("SELECT * FROM consultorios")
        data = cur.fetchall()
        return jsonify({"status": "success", "consultorios": data})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cur.close()
        conn.close()

# =========================================================
# TRATAMIENTOS
# =========================================================
@app.route('/api/tratamientos', methods=['GET'])
def api_tratamientos():
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        cur.execute("SELECT * FROM tratamientos")
        data = cur.fetchall()
        return jsonify({"status": "success", "tratamientos": data})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cur.close()
        conn.close()

# =========================================================
# CITAS
# =========================================================
@app.route('/api/citas', methods=['GET'])
def api_citas():
    try:
        conn = connect_to_db()
        cur = conn.cursor()
        cur.execute("SELECT * FROM citas")
        data = cur.fetchall()
        return jsonify({"status": "success", "citas": data})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        cur.close()
        conn.close()

# =========================================================
# INICIO DE LA APP
# =========================================================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5050, debug=True)
