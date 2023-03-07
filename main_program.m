matric_row = 100;
matric_BA = -generate_BA(8, matric_row);

num_del = 5;
matric_w_max = generate_matric_del(matric_BA, num_del, 'max');
eig_w_max = eigs(matric_w_max,1,'sa');

num_del = 21;
matric_w_min = generate_matric_del(matric_BA, num_del, 'min');
eig_w_min = eigs(matric_w_min,1,'sa');

num_del = 21;
matric_w_random = generate_matric_del(matric_BA, num_del, 'random');
eig_w_random = eigs(matric_w_random,1,'sa');