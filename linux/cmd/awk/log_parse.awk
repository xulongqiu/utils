#!/usr/bin/awk -f

BEGIN{
    print "START"
}
match($0, /uri:(.+)\ cost\[([0-9]+)ms\]/, array) {
    uri_cost[array[1]]+=array[2];uri_cnt[array[1]] += 1;
}
END{
    for (uri in uri_cost) {
        print uri, uri_cost[uri] / uri_cnt[uri] "ms"
    }

    print "END"
}
