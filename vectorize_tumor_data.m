function data_vec = vectorize_tumor_data(data, mask)
    
    % tumor seed values
    [j_t,i_t] = find(data.seed == 1);    
    t = zeros(length(j_t), length(mask) + 2);
    for i = 1:length(j_t)
        t(i,:) = [...
            reshape(data.img(j_t(i), i_t(i), mask), [1 length(mask)]),...
            j_t(i), ...
            i_t(i)...
        ];
    end
    
    % fluid seed values
    [j_e,i_e] = find(data.seed == 2);
    e = zeros(length(j_e), length(mask) + 2);
    for i = 1:length(j_e)
        e(i,:) = [...
            reshape(data.img(j_e(i), i_e(i), mask), [1 length(mask)]),...
            j_e(i), ...
            i_e(i)...
        ];
    end
    
    % brain seed values
    [j_b,i_b] = find(data.seed == 3);
    b = zeros(length(j_b), length(mask) + 2);
    for i = 1:length(j_b)
        b(i,:) = [...
            reshape(data.img(j_b(i), i_b(i), mask), [1 length(mask)]),...
            j_b(i), ...
            i_b(i)...
        ];
    end
    
    % unlabled values
    [j_r,i_r] = find(data.seed == 0);
    r = zeros(length(j_r), length(mask) + 2);
    for i = 1:length(j_r)
        r(i,:) = [...
            reshape(data.img(j_r(i), i_r(i), mask), [1 length(mask)]),...
            j_r(i), ...
            i_r(i)...
        ];
    end
    
    data_vec=struct();
    data_vec.X = [t; e; b; r];    
    data_vec.Y = [...
		1 * ones(size(t, 1), 1); ...
		2 * ones(size(e, 1), 1); ...
		3 * ones(size(b, 1), 1); ...
		4 * ones(size(r, 1), 1); ...
	];
    mean_r = [zeros(1, size(r,2)-2), mean(r(:,size(r, 2)-1)), mean(r(:,size(r, 2)))];
    std_r = [ones(1, size(r,2)-2), std(r(:,size(r, 2)-1)), std(r(:,size(r, 2)))];

    data_vec.C_ave = [ mean(t,1); mean(e,1); mean(b,1); mean_r];
    data_vec.C_std = [ std(t,1); std(e,1); std(b,1); std_r];

    
    data_vec.img = data.img;
    data_vec.seg = data.seg;
    data_vec.seed = data.seed;
    data_vec.spacing = data.spacing;
    data_vec.ext = data.ext;
end
    
    