<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="ElAhorcado.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #6542c3, #5e2b88);
            color: #ffffff;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        main {
            max-width: 800px;
            padding: 20px;
            background: rgba(0, 0, 0, 0.4);
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.6);
            text-align: justify;
        }

        h2, h3 {
            text-align: center;
        }

        ul {
            text-align: left;
            padding-left: 20px;
        }

        p {
            margin-bottom: 20px;
        }
    </style>
    <main aria-labelledby="title">
        <h2 id="title">Reglas del Juego: El Ahorcado</h2>
        <h3>Cómo jugar:</h3>
        <p>
            El objetivo del juego es adivinar una palabra secreta antes de que se complete el dibujo del ahorcado.
        </p>
        <ul>
            <li>El jugador tiene un número limitado de intentos para adivinar la palabra.</li>
            <li>Por cada letra incorrecta, se añade una parte al dibujo del ahorcado (por ejemplo: cabeza, cuerpo, brazos, piernas, etc.).</li>
            <li>Si el dibujo se completa antes de que el jugador adivine la palabra, el jugador pierde.</li>
            <li>Si el jugador adivina todas las letras de la palabra antes de que se complete el dibujo, gana el juego.</li>
        </ul>
        <h3>Reglas adicionales:</h3>
        <p>
            - Solo puedes adivinar una letra a la vez.  
            - Si adivinas una letra que aparece varias veces, todas las posiciones serán reveladas.  
            - Las palabras pueden incluir letras de la A a la Z (sin caracteres especiales ni números).  
        </p>
        <h3>¡Buena suerte!</h3>
    </main>
</asp:Content>
