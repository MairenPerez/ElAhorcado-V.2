<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ElAhorcado._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #6542c3, #5e2b88);
            color: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            text-align: center;
            min-height: 100vh;
            position: relative;
        }

        h1 {
            font-size: 3.5rem;
            margin-bottom: 10px;
            text-shadow: 2px 4px 5px rgba(0, 0, 0, 0.5);
        }

        p {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        .game-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 30px;
            padding: 45px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width:auto;
}
        svg {
            display: block;
            margin: 0 auto;
        }

        .figure-part {
            display: none;
            stroke: #fff;
            stroke-width: 2;
        }

        .wrong-letters-container {
            margin-top: 10px;
        }

        .wrong-letters-container span {
            display: inline-block;
            font-size: 1.2rem;
            margin-right: 8px;
        }

        .word {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }

        .letter {
            font-size: 2rem;
            border-bottom: 2px solid #ffffff;
            width: 40px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .popup-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            visibility: hidden;
            opacity: 0;
            transition: opacity 0.3s ease-in-out, visibility 0.3s ease-in-out;
        }

        .popup-container.active {
            visibility: visible;
            opacity: 1;
        }

        .popup {
            background: #fff;
            color: #333;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .popup h2 {
            font-size: 2rem;
            margin-bottom: 15px;
        }

        .popup button {
            background: #6542c3;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
        }

        .notification-container {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(255, 255, 255, 0.8);
            padding: 10px 20px;
            border-radius: 5px;
            color: #333;
            font-weight: bold;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
        }

        .notification-container.show {
            opacity: 1;
        }

        .keyboard {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 20px;
            gap: 5px;
        }

        .key {
            background: #5e2b88;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            font-size: 1rem;
            cursor: pointer;
            text-transform: uppercase;
        }

        .key.used {
            background: #ccc;
            color: #333;
            cursor: not-allowed;
        }
    </style>

    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">¡Que empiece el juego!</h1>
            <p class="lead">¡Encuentra la palabra antes de que sea demasiado tarde!</p>
        </section>

        <div class="row">
           <div class="col">
<%--               <asp:Button ID="Button1" runat="server" Text="Jugar" CssClass="btn-primary"/>--%>
           </div>
        </div>

        <div class="game-container">
            <!-- SVG para el ahorcado -->
            <svg height="250" width="200">
                <line x1="60" y1="20" x2="140" y2="20" stroke="#fff" stroke-width="2"/> <!-- Barra superior -->
                <line x1="140" y1="20" x2="140" y2="50" stroke="#fff" stroke-width="2"/> <!-- Barra vertical -->
                <line x1="60" y1="20" x2="60" y2="230" stroke="#fff" stroke-width="2"/> <!-- Barra vertical izquierda -->
                <line x1="20" y1="230" x2="100" y2="230" stroke="#fff" stroke-width="2"/> <!-- Base -->
                <circle cx="140" cy="70" r="20" class="figure-part" stroke="#fff" stroke-width="2"/> <!-- Cabeza -->
                <line x1="140" y1="90" x2="140" y2="150" class="figure-part" stroke="#fff" stroke-width="2"/> <!-- Cuerpo -->
                <line x1="140" y1="120" x2="120" y2="100" class="figure-part" stroke="#fff" stroke-width="2"/> <!-- Brazo izquierdo -->
                <line x1="140" y1="120" x2="160" y2="100" class="figure-part" stroke="#fff" stroke-width="2"/> <!-- Brazo derecho -->
                <line x1="140" y1="150" x2="120" y2="180" class="figure-part" stroke="#fff" stroke-width="2"/> <!-- Pierna izquierda -->
                <line x1="140" y1="150" x2="160" y2="180" class="figure-part" stroke="#fff" stroke-width="2"/> <!-- Pierna derecha -->
            </svg>

            <!-- Letras incorrectas -->
            <div class="wrong-letters-container">
                <p>Letras incorrectas:</p>
                <div id="wrong-letters"></div>
            </div>

            <!-- Palabra -->
            <div class="word" id="word"></div>
        </div>

        <!-- Teclado -->
        <div class="keyboard" id="keyboard">
            <!-- Las letras se generarán dinámicamente -->
        </div>

        <!-- Popup de final -->
        <div class="popup-container" id="popup-container">
            <div class="popup">
                <h2 id="final-message"></h2>
                <button id="play-button">Jugar de Nuevo</button>
            </div>
        </div>

        <!-- Notificación -->
        <div class="notification-container" id="notification-container">
            Ya usaste esa letra
        </div>
    </main>

     <script>

         // Variables 
         const words = ['programacion', 'romanticismo', 'backend', 'rocknroll', 'bateria', 'deportes'];
         let selectedWord = words[Math.floor(Math.random() * words.length)];

         const correctLetters = [];
         const wrongLetters = [];
         const wordE1 = document.getElementById('word');
         const wrongLettersE1 = document.getElementById('wrong-letters');
         const popupContainer = document.getElementById('popup-container');
         const finalMessage = document.getElementById('final-message');
         const playButton = document.getElementById('play-button');
         const notification = document.getElementById('notification-container');
         const figureParts = document.querySelectorAll('.figure-part');
         const keyboard = document.getElementById('keyboard');

         // Mostramos la palabra segun se vayan acertando las letras.
         function displayWord() {
             wordE1.innerHTML = selectedWord
                 .split('')
                 .map(letter => `<span class="letter">${correctLetters.includes(letter) ? letter : ''}</span>`)
                 .join('');
             if (wordE1.innerText.replace(/\n/g, '') === selectedWord) {
                 finalMessage.innerText = '¡Felicidades, ganaste!';
                 popupContainer.classList.add('active');
             }
         }

         // Actualizamos las letras incorrectas y las mostramos en la parte superior del juego.
         function updateWrongLetters() {
             wrongLettersE1.innerHTML = wrongLetters.map(letter => `<span>${letter}</span>`).join('');
             figureParts.forEach((part, index) => {
                 if (index < wrongLetters.length) {
                     part.style.display = 'block';
                 }
             });
             if (wrongLetters.length === figureParts.length) {
                 finalMessage.innerText = '¡Perdiste! La palabra era ' + selectedWord;
                 popupContainer.classList.add('active');
             }
         }

         // Evento para el teclado
         function handleKeyPress(event) {
             const letter = event.key.toLowerCase();
             if (correctLetters.includes(letter) || wrongLetters.includes(letter)) {
                 // Ya se usó la letra
                 notification.classList.add('show');
                 setTimeout(() => notification.classList.remove('show'), 1500);
                 return;
             }

             if (selectedWord.includes(letter)) {
                 correctLetters.push(letter);
                 displayWord();
             } else {
                 wrongLetters.push(letter);
                 updateWrongLetters();
             }
         }

         // Inicializamos el teclado y el juego cuando la página carga.
         function setupKeyboard() {
             const letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
             keyboard.innerHTML = letters
                 .map(letter => `<button class="key" id="${letter}">${letter}</button>`)
                 .join('');
             document.querySelectorAll('.key').forEach(button => {
                 button.addEventListener('click', () => {
                     const letter = button.innerText;
                     button.classList.add('used');
                     handleKeyPress({ key: letter });
                 });
             });
         }

         playButton.addEventListener('click', () => {
             window.location.reload();
         });

         window.addEventListener('keydown', handleKeyPress);

         // Iniciamos el juego
         displayWord();
     </script>
</asp:Content>
