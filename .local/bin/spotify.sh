running=$(ps au | grep "spotify")
if [ "$running" != "" ]; then
    artist=$(playerctl metadata artist)
    song=$(playerctl metadata title | cut -c 1-60)
    echo -n "<fc=#b16286> $artist ->> $song</fc>"
else
    echo -n "<fc=#b16286>  󰓄</fc>"
fi

