use strict;
use warnings;
use URI::Escape;
use FindBin;
use lib "$FindBin::Bin/../../modules/";
use Gambot::GAPIL::CommandChild;
use Gambot::IRC::Freenode::Specifications;
use Gambot::IRC::Freenode::Parser;
use Gambot::IRC::Freenode::Output;

$| = 1;

my $core = new Gambot::GAPIL::CommandChild;
$core->{'parser'} = new Gambot::IRC::Freenode::Parser($core);
$core->{'output'} = new Gambot::IRC::Freenode::Output($core);

$core->{'childid'} = stdin_read();
$core->{'botname'} = stdin_read();
$core->{'incoming_message'} = stdin_read();
$core->{'triggers'} = ();

(
  $core->{'nick'},
  $core->{'user'},
  $core->{'host'},
  $core->{'chan'},
  $core->{'command'},
  $core->{'message'},
  $core->{'event'}
) = $core->{'parser'}->parse($core->{'botname'},$core->{'incoming_message'});

$core->{'pinged'} = '';
$core->{'target'} = $core->{'nick'};

if($core->{'event'} eq 'on_private_message') {
  $core->{'pinged'} = 1;
}

if($core->{'event'} eq 'on_public_message') {
  my $botname = $core->{'botname'};

  if($core->{'message'} =~ /@([, $charactersNick]+)$/) {
    $core->{'target'} = $1;
    $core->{'message'} =~ s/ ?@$1$//;
  }

  if($core->{'message'} =~ /^(${botname}[:,] )/ or $core->{'message'} =~ /^(&)/) {
    $core->{'pinged'} = 1;
    $core->{'message'} =~ s/^$1//;
  }
}

sub module_load {
  my ($module) = @_;
  (my $file = $module) =~ s|::|/|g;
  require $file.'.pm';
  $module->match($core);
}



module_load('PluginParser::Public::ServerPing');
module_load('PluginParser::Public::Hug');
module_load('PluginParser::Public::Time');
module_load('PluginParser::Public::Subreddit');