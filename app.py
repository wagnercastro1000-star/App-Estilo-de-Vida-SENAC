# Importação das bibliotecas necessárias do Flask
from flask import Flask, request, Response, jsonify

# Permite que o front-end acesse a API mesmo estando em outra porta
# (resolve o erro de CORS encontrado durante os testes)
from flask_cors import CORS

# Importação das funções do projeto
from grafico import gerar_svg
from database import salvar_respostas

# Criação da aplicação Flask
app = Flask(__name__)

# Habilita o compartilhamento de recursos entre origens diferentes
# Exemplo:
# Front-end -> http://127.0.0.1:5500
# Back-end  -> http://127.0.0.1:5000
CORS(app)


# Rota responsável por receber as respostas do questionário
@app.route("/api/feedback", methods=["POST"])
def feedback():

    # Recebe os dados enviados pelo front-end em formato JSON
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

    # Verifica se as 15 perguntas foram respondidas
    perguntas_esperadas = {str(i) for i in range(1, 16)}

    if set(respostas_recebidas.keys()) != perguntas_esperadas:
        return jsonify({
            "erro": "É necessário responder às 15 perguntas."
        }), 400

    respostas = {}

    # Valida cada resposta recebida
    for pergunta in range(1, 16):

        nota = respostas_recebidas[str(pergunta)]

        # As notas permitidas vão de 0 a 3
        if type(nota) is not int or nota not in range(4):
            return jsonify({
                "erro": f"Nota inválida na pergunta {pergunta}."
            }), 400

        respostas[pergunta] = nota

    # Salva as respostas no banco de dados
    try:

        salvar_respostas(id_usuario, respostas)

    except ValueError as erro:

        return jsonify({"erro": str(erro)}), 400

    except Exception:

        app.logger.exception("Erro ao salvar respostas.")

        return jsonify({
            "erro": "Não foi possível salvar as respostas."
        }), 500

    # Gera o gráfico SVG com base nas respostas
    svg = gerar_svg(respostas)

    # Retorna o gráfico para o navegador
    return Response(
        svg,
        mimetype="image/svg+xml",
        headers={
            "Content-Disposition": "inline; filename=feedback.svg"
        }
    )


# Inicialização do servidor Flask
if __name__ == "__main__":
    app.run(debug=True)