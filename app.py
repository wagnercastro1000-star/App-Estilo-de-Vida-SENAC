
from flask import Flask, request, Response, jsonify

from grafico import gerar_svg
from database import salvar_respostas

app = Flask(__name__)


@app.route("/api/feedback", methods=["POST"])
def feedback():

    dados = request.get_json(silent=True)

    if not isinstance(dados, dict):
        return jsonify({"erro": "JSON inválido."}), 400

    id_usuario = dados.get("id_usuario")
    respostas_recebidas = dados.get("respostas")

    # Validação do usuário
    if type(id_usuario) is not int or id_usuario <= 0:
        return jsonify({"erro": "ID de usuário inválido."}), 400

    # Validação das respostas
    if not isinstance(respostas_recebidas, dict):
        return jsonify({"erro": "Respostas inválidas."}), 400

    perguntas_esperadas = {str(i) for i in range(1, 16)}

    if set(respostas_recebidas.keys()) != perguntas_esperadas:
        return jsonify({
            "erro": "É necessário responder às 15 perguntas."
        }), 400

    respostas = {}

    for pergunta in range(1, 16):

        nota = respostas_recebidas[str(pergunta)]

        if type(nota) is not int or nota not in range(4):
            return jsonify({
                "erro": f"Nota inválida na pergunta {pergunta}."
            }), 400

        respostas[pergunta] = nota

    # Salva as respostas no MySQL
    try:

        salvar_respostas(id_usuario, respostas)

    except ValueError as erro:

        return jsonify({"erro": str(erro)}), 400

    except Exception:

        app.logger.exception("Erro ao salvar respostas.")

        return jsonify({
            "erro": "Não foi possível salvar as respostas."
        }), 500

    # Gera o gráfico SVG
    svg = gerar_svg(respostas)

    # Devolve a imagem ao solicitante
    return Response(
        svg,
        mimetype="image/svg+xml",
        headers={
            "Content-Disposition": "inline; filename=feedback.svg"
        }
    )


if __name__ == "__main__":
    app.run(debug=True)
