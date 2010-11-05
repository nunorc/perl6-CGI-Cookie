use CGI::Cookie;
use Test;

plan *;

my $c = CGI::Cookie.new({name1=>'value1'});

ok $c.WHAT eq 'CGI::Cookie()', 'simple';
ok $c.param('name1') eq 'value1', 'simple param';
ok $c.bake ~~ /'Set-Cookie: name1=value1; path=/'/, 'simple bake';

done_testing;
