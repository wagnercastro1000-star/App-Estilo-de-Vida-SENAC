const perguntas = [

    "Consumo frutas diariamente.",
    "Faço refeições equilibradas.",
    "Evito alimentos ultraprocessados.",

    "Pratico exercícios regularmente.",
    "Caminho durante o dia.",
    "Faço alongamentos ou atividades corporais.",

    "Consigo lidar com situações estressantes.",
    "Reservo momentos de lazer.",
    "Durmo adequadamente.",

    "Mantenho boas relações pessoais.",
    "Converso frequentemente com amigos e familiares.",
    "Participo de atividades sociais.",

    "Realizo consultas médicas periódicas.",
    "Faço exames preventivos regularmente.",
    "Evito hábitos prejudiciais à saúde."
];

const categorias = [
    "Nutrição",
    "Atividade Física",
    "Controle do Estresse",
    "Relacionamentos",
    "Comportamento Preventivo"
];

const container =
    document.getElementById("perguntas-container");

let contador = 0;

categorias.forEach(categoria => {

    const titulo = document.createElement("h2");
    titulo.className = "categoria";
    titulo.textContent = categoria;

    container.appendChild(titulo);

    for (let i = 0; i < 3; i++) {

        contador++;

        const div = document.createElement("div");
        div.className = "pergunta";

        div.innerHTML = `
            <h3>${contador}. ${perguntas[contador - 1]}</h3>

            <div class="opcoes">

                <label>
                    <input type="radio" name="p${contador}" value="0">
                    Nunca
                </label>

                <label>
                    <input type="radio" name="p${contador}" value="1">
                    Às vezes
                </label>

                <label>
                    <input type="radio" name="p${contador}" value="2">
                    Frequentemente
                </label>

                <label>
                    <input type="radio" name="p${contador}" value="3">
                    Sempre
                </label>

            </div>
        `;

        container.appendChild(div);
    }
});

document
    .getElementById("enviarBtn")
    .addEventListener("click", enviarRespostas);

async function enviarRespostas() {

    const idUsuario =
        parseInt(
            document.getElementById("idUsuario").value
        );

    if (!idUsuario) {
        alert("Informe o ID do usuário.");
        return;
    }

    const respostas = {};

    for (let i = 1; i <= 15; i++) {

        const resposta =
            document.querySelector(
                `input[name="p${i}"]:checked`
            );

        if (!resposta) {
            alert(`Responda a pergunta ${i}.`);
            return;
        }

        respostas[i] = parseInt(resposta.value);
    }

    try {

        const retorno = await fetch(
            "http://localhost:5000/api/feedback",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    id_usuario: idUsuario,
                    respostas: respostas
                })
            }
        );

        if (!retorno.ok) {
            throw new Error("Erro ao enviar dados.");
        }

        const svg = await retorno.text();

        document
            .getElementById("resultado")
            .innerHTML = `
                <h2>Resultado da Avaliação</h2>
                ${svg}
            `;

        window.scrollTo({
            top: document.body.scrollHeight,
            behavior: "smooth"
        });

    } catch (erro) {

        console.error(erro);

        alert(
            "Não foi possível conectar ao servidor."
        );
    }
}