
import math


def coordenadas(cx, cy, raio, angulo):

    rad = math.radians(angulo)

    x = cx + raio * math.cos(rad)
    y = cy + raio * math.sin(rad)

    return x, y


def criar_pontos(respostas, cx, cy, raio_maximo):
    
    pontos = []

    for i in range(15):

        angulo = -90 + (i // 3) * 72 + ((i % 3) - 1) * 24

        nota = respostas[i + 1]

        raio = raio_maximo * nota / 3

        x, y = coordenadas(cx, cy, raio, angulo)

        pontos.append((x, y))

    return pontos


def gerar_svg(respostas):

    largura = 640
    altura = 640

    cx = 320
    cy = 320

    raio_maximo = 125

    raio_externo = 295
    raio_interno = 140

    svg = []

    svg.append(f"""
    <svg xmlns="http://www.w3.org/2000/svg"
         width="{largura}"
         height="{altura}"
         viewBox="0 0 {largura} {altura}">
    """)

    # 1. Contorno externo da estrela de cinco pontas

    vertices = []

    for i in range(10):

        angulo = -90 + i * 36

        raio = raio_externo if i % 2 == 0 else raio_interno

        x, y = coordenadas(cx, cy, raio, angulo)

        vertices.append(f"{x},{y}")

    svg.append(f"""
        <polygon
            points="{' '.join(vertices)}"
            fill="white"
            stroke="black"
            stroke-width="5"
            stroke-linejoin="miter"
        />
    """)

    # 2. Polígono preenchido conforme as respostas

    pontos = criar_pontos(
        respostas,
        cx,
        cy,
        raio_maximo
    )

    coordenadas_poligono = " ".join(
        f"{x},{y}" for x, y in pontos
    )

    svg.append(f"""
        <polygon
            points="{coordenadas_poligono}"
            fill="#39A935"
            fill-opacity="0.90"
            stroke="#246F22"
            stroke-width="2"
            stroke-linejoin="round"
        />
    """)

    # 3. Círculos de pontuação

    for nivel in range(1, 4):

        raio = raio_maximo * nivel / 3

        svg.append(f"""
            <circle
                cx="{cx}"
                cy="{cy}"
                r="{raio}"
                fill="none"
                stroke="black"
                stroke-width="1.2"
                stroke-dasharray="4 3"
            />
        """)

    # 4. Eixos das 15 perguntas

    for i in range(15):

        angulo = -90 + (i // 3) * 72 + ((i % 3) - 1) * 24

        x, y = coordenadas(
            cx,
            cy,
            raio_maximo,
            angulo
        )

        svg.append(f"""
            <line
                x1="{cx}"
                y1="{cy}"
                x2="{x}"
                y2="{y}"
                stroke="black"
                stroke-width="1"
                stroke-dasharray="4 3"
            />
        """)

    # 5. Cinco linhas principais da estrela

    for i in range(5):

        angulo = -90 + i * 72

        x, y = coordenadas(
            cx,
            cy,
            raio_externo,
            angulo
        )

        svg.append(f"""
            <line
                x1="{cx}"
                y1="{cy}"
                x2="{x}"
                y2="{y}"
                stroke="black"
                stroke-width="2"
            />
        """)

    # 6. Centro do gráfico

    svg.append(f"""
        <circle
            cx="{cx}"
            cy="{cy}"
            r="3"
            fill="black"
        />
    """)

    svg.append("</svg>")

    return "".join(svg)
