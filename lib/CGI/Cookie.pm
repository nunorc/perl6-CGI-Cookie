class CGI::Cookie;

has %.data;

method new(%data = {}) {
	%data{'path'} = '/' unless %data{'path'};

	return self.bless(*, :%data);
}

method param($key) {
	%.data{$key};
}

method parse() {
	my $raw = self.get_raw();
	for $raw.split(';') {
		my($key,$value) = split "=", $_;
		%.data{$key} = $value if $key;
	}
	%.data;
}

method get_raw() {
	%*ENV<HTTP_COOKIE>;
}

method bake() {
	my @values;
	for self.data.keys { @values.push($_ ~ '=' ~ self.param($_)) }

	"Set-Cookie: " ~ @values.join('; ') ~ "\n";
}

