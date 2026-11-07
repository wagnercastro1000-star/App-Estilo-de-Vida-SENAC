
import mysql.connector

def conectar_banco():

    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )


def salvar_respostas(id_usuario, respostas):

    conexao = conectar_banco()
    cursor = conexao.cursor(dictionary=True)

    try:

        cursor.execute("""
            SELECT id_usuario
            FROM usuario
            WHERE id_usuario = %s
        """, (id_usuario,))

        if cursor.fetchone() is None:
            raise ValueError("Usuário não encontrado.")

        for id_pergunta, nota in respostas.items():

            cursor.execute("""
                SELECT id_opcao
                FROM opcoes_resposta
                WHERE id_pergunta = %s
                AND texto_opcao LIKE %s
            """, (id_pergunta, f'[{nota}]%'))

            opcao = cursor.fetchone()

            if opcao is None:
                raise ValueError(
                    f"Opção não encontrada na pergunta {id_pergunta}."
                )

            cursor.execute("""
                INSERT INTO resposta_escolhida
                (id_usuario, id_pergunta, id_opcao)

                VALUES (%s, %s, %s)

                ON DUPLICATE KEY UPDATE
                id_opcao = VALUES(id_opcao)
            """, (
                id_usuario,
                id_pergunta,
                opcao["id_opcao"]
            ))

        conexao.commit()

    except Exception:
        conexao.rollback()
        raise

    finally:
        cursor.close()
        conexao.close()

import os
import mysql.connector
from dotenv import load_dotenv

load_dotenv()

