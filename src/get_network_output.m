% Parameters
% net:		neural network - cell array
% net{m}:	matrix (I+1)xO - I amount of input values, +1 for the -1 
% in:		matrix NxM - N amount of test cases - M amount of input values
% g:		transference function
%
%
function o = get_network_output(net, in, g) 
	layer_in = in;
	for m=1:size(net)(2)
		layer_out = g([(ones(size(layer_in)(1),1)*(-1)) layer_in]*net{m});
		layer_in = layer_out;
	end
	o = layer_out;
end


% Example XOR
% Page 32

% in = [0 0 ; 0 1 ; 1 0 ; 1 1];				4x2
% net{1} = [0.5 1.5 ; 1 1 ; 1 1]			3x2
% net{2} = [0.5 ; 1 ; -2]					3x1


%
%			o 				3x1
%	  *	  o   o  			3x2
%		*	o 	o 		


% get_network_output(net,in,@step_ft)		4x1