function terr_n = normalize_sampling(tanh_f,M,terr)
	N = size(terr)(1); D = size(terr)(2);
	for k=1:D
		terr_k = terr(:,k);
		%Normalization
		terr_n(:,k) = terr_k .- M(k,1); 
		terr_n(:,k) = terr_n(:,k).*(1/(M(k,2)-M(k,1))); % between 0 and 1
		if tanh_f
			terr_n(:,k) = terr_n(:,k).*2-1; % between -1 and 1
		end
	end
end