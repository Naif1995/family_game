// IMPORTS
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const getSentence = require("./api/getSentence");
const Game = require("./models/Game");

// create a server
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require("socket.io")(server);

// middle ware
app.use(express.json());

// connect to mongodb
const DB =
    "mongodb+srv://mongodb:mongodb@cluster0.ohmmyvv.mongodb.net/family_game?retryWrites=true&w=majority";

// listening to socket io events from the client (flutter code)
io.on("connection", (socket) => {
    socket.on("create-game", async ({ nickname }) => {
        try {
            let game = new Game();
            const sentence = await getSentence();
            game.words = sentence;
            let player = {
                socketID: socket.id,
                nickname,
                isPartyLeader: true,
            };
            game.players.push(player);
            game = await game.save();

            const gameId = game._id.toString();
            socket.join(gameId);
            io.to(gameId).emit("updateGame", game);
        } catch (e) {
            console.log(e);
        }
    })
    socket.on("join-game", async ({ nickname, gameId }) => {

        try {
            if(!mongoose.Types.ObjectId.isValid(gameId)){
                socket.emit("invalid-game-id",'Please enter a valid game id');
                return;
            }
            let game = await Game.findById(gameId);

            if(game.isJoin) {
                const id = game._id.toString();
                let player = { socketID: socket.id, nickname };
                socket.join(id);
                game.players.push(player);
                game = await game.save();
            }
        }catch(e){
            console.log(e);
        }
    });
});
mongoose.set('strictQuery', false);
mongoose
    .connect(DB)
    .then(() => {
        console.log("Connection Successful!");
    })
    .catch((e) => {
        console.log(e);
    });

// listen to server
server.listen(port, "0.0.0.0", () => {
    console.log(`Server started and running on port ${port}`);
});