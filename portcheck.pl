/* AUTHOR: VHarisop <https://github.com/VHarisop>
*  
*  This is a threaded implementation of a port checker using sockets
*  in SWI-Prolog. It uses the builtin socket library of swi-prolog.
*/



/* probe_socket/3 checks a socket for an ACK response 
 * returning [+] if socket is open and [-] otherwise 
 */
probe_socket(Host, Port, Status) :- 
	catch(setup_call_cleanup((tcp_socket(Socket), 
									  Status = '[+]'), 
									  tcp_connect(Socket, Host:Port),
									  tcp_close_socket(Socket)), 
									  _,
									  Status = '[-]').
/* create a threaded version for each socket
 * and store the ids for thread joining */
probe_sockets(Host, [P|Ps], Ids, Acc) :- 
	thread_create(probe_socket_threaded(Host, P, _), Id, []), 
	probe_sockets(Host, Ps, [Id|Ids], Acc).
probe_sockets(_, [], Ids, Ids).			

/* threaded version of socket probing */
probe_socket_threaded(Host, Port, Status) :-								  
	/* 5-second time out for socket response */
	call_with_time_limit(
		3, probe_socket(Host, Port, Status)
	),  
	thread_exit((Host:Port, Status)).

probe_sockets(Host, Ports) :-
	probe_sockets(Host, Ports, [], Ids),
	join_threads(Ids).

join_threads([Id|Ids]) :- 
	thread_join(Id, exited(Args)),
	writeln(Args),
	join_threads(Ids).
join_threads([]).

					 
/* test a commonly known website */
test :- probe_sockets('www.google.com', [80, 443, 120, 127, 32]).
