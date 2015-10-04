#super simple script to display todo list
quiet=0;
prompt=0;
#too lazy to look up how to properly do shell arguments
if [ "$1" == "--quiet" -o "$2" == "--quiet" ]; then
    quiet=1;
fi
if [ "$1" == "--prompt" -o "$2" == "--prompt" ]; then
    prompt=1;
fi

start=$(date +"%Y-%m-%d");
tasks=$(grep "@due($(date +%-m-%-d))" ~/tasks.todo);
wc=$(grep "@due($(date +%-m-%-d))" ~/tasks.todo | wc -l);
test "$prompt" == 0 && test "$quiet" == 0 && echo Todo:
#check today tasks
if [ "$tasks" ]; then
    tasks="$(echo -e $tasks | sed -r 's/.*@due//g')"
    test "$prompt" == 0 && test "$quiet" == 0 && echo Today:
    test "$prompt" == 0 && echo $tasks;
    task=t
fi

#check week tasks
tasks=""
start=$(date --date="$start + 1 day" +"%Y-%m-%d")
end=$(date --date="$start + 6 days" +"%Y-%m-%d")
wc=$(($wc+$(grep "@due($(date --date="$start" +%-m-%-d))" ~/tasks.todo | wc -l)));
test "$prompt" == 1 && echo [$wc] && exit;
while [[ $start < $end ]]; do
    if [ "$(grep "@due($(date --date="$start" +%-m-%-d))" ~/tasks.todo)" ]; then
        tasks+=$(grep "@due($(date --date="$start" +%-m-%-d))" ~/tasks.todo)\\n
    fi
    start=$(date --date="$start + 1 day" +"%Y-%m-%d")
done
if [ "$tasks" ]; then
    test "$quiet" == 0 && echo -ne \\nThis week:
    tasks="$(echo -e $tasks | sed -r 's/☐ *@due/\\n/g')"
    echo -e $tasks
    task=t
fi

#check month tasks
tasks=""
end=$(date --date="$start + 3 weeks" +"%Y-%m-%d")
while [[ $start < $end ]]; do
    if [ "$(grep "@due($(date --date="$start" +%-m-%-d))" ~/tasks.todo)" ]; then
        tasks+=$(grep "@due($(date --date="$start" +%-m-%-d))" ~/tasks.todo)\\n
    fi
    start=$(date --date="$start + 1 day" +"%Y-%m-%d")
done
if [ "$tasks" ]; then
    test "$quiet" == 0 && echo -ne \\nThis month:
    tasks="$(echo -e $tasks | sed -r 's/.*@due/\\n/g')"
    echo -e $tasks
    task=t
fi


if [ "$task" == 0 ]; then
    echo Nothing to do
fi

