if ($message =~ /^$sl !op ([$valid_chan_characters]+) ([$valid_nick_characters]+)$/) {
  CheckAuth($1,$hostname) ? ACT('MESSAGE','chanserv',"op $1 $2") : AuthError($sender,$target,$1);
}

if ($message =~ /^$sl !deop ([$valid_chan_characters]+) ([$valid_nick_characters]+)$/) {
  CheckAuth($1,$hostname) ? ACT('MESSAGE','chanserv',"deop $1 $2") : AuthError($sender,$target,$1);
}

if ($message =~ /^$sl !opme$/) {
  CheckAuth($target,$hostname) ? ACT('MESSAGE','chanserv',"op $target $receiver") : AuthError($sender,$target,$target);
}

if ($message =~ /^$sl !deopme$/) {
  CheckAuth($target,$hostname) ? ACT('MESSAGE','chanserv',"deop $target $receiver") : AuthError($sender,$target,$target);
}

if ($message =~ /^$sl !opyou$/) {
  CheckAuth($target,$hostname) ? ACT('MESSAGE','chanserv',"op $target $self") : AuthError($sender,$target,$target);
}

if ($message =~ /^$sl !deopyou$/) {
  CheckAuth($target,$hostname) ? ACT('MESSAGE','chanserv',"deop $target $self") : AuthError($sender,$target,$target);
}