function t = get_training_set( N , g )

	bits = logical([0,1]);
	
	% boolean matrix
	switch(N) 
	case 2
		[b,a] = ndgrid(bits,bits); 
		t{1} = [a(:), b(:)];
	case 3
		[c,b,a] = ndgrid(bits,bits,bits); 
		t{1} = [a(:), b(:), c(:)];
	case 4
		[d,c,b,a] = ndgrid(bits,bits,bits,bits); 
		t{1} = [a(:), b(:), c(:), d(:)];	
	case 5
		[e,d,c,b,a] = ndgrid(bits,bits,bits,bits,bits); 
		t{1} = [a(:), b(:), c(:), d(:), e(:)];
	otherwise
		error;
	end

	% eval vector
	t{2} = zeros(2^N,1);

	for k=1:(2^N)
		a = t{1}(k,:)(1);
		for p=2:N
			a = g(a,(t{1}(k,:)(p)));
		end
		t{2}(k) = a;
	end


end