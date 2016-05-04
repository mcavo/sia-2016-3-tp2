% Parameters
% net:		neural network
% in:		matrix of NxM, been N the amount of patterns and M the amount of input values (dont include the -1 value)
% g:		Activation function
%
% o:	
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
% Page 

% in = [0 0 ; 0 1 ; 1 0 ; 1 1];				4x2
% net{1} = [0.5 1.5 ; 1 1 ; 1 1]			2x3
% net{2} = [0.5 ; 1 ; -2]					3x1

% get_network_output(net,in,@step_ft)		4x1