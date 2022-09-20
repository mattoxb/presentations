#! zsh

while true; do
    inotifywait -e modify **/*.tex
    build-slides
done
