%% Demo 1
figure; 
mu = [0 0];

sigma = [1   0; ...
         0   1];
R = chol(sigma);
data = repmat(mu, 1000, 1) + randn(1000,2) * R;
subplot(2,2,1);
plot(data(:,1), data(:,2), '.' );

[coefs,scores,variances] = pca( data );
hold on;
plot( [0, coefs(1,1)], [0, coefs(2,1)], 'r-', 'LineWidth', 2 );
plot( [0, coefs(1,2)], [0, coefs(2,2)], 'r-', 'LineWidth', 2 );
title( ['cov = 0, lamda_1 = ', num2str(variances(1)), ', lamda_2 = ', num2str(variances(2))] );
axis( [-4.5, 4.5, -4.5 4.5] );
hold off;

sigma = [1   0.5; ...
         0.5   1];
R = chol(sigma);
data = repmat(mu, 1000, 1) + randn(1000,2) * R;
subplot(2,2,2);
plot(data(:,1), data(:,2), '.' );

[coefs,scores,variances] = pca( data );
hold on;
plot( [0, coefs(1,1)], [0, coefs(2,1)], 'r-', 'LineWidth', 2 );
plot( [0, coefs(1,2)], [0, coefs(2,2)], 'r-', 'LineWidth', 2 );
title( ['cov = 0.5, lamda_1 = ', num2str(variances(1)), ', lamda_2 = ', num2str(variances(2))] );
axis( [-4.5, 4.5, -4.5 4.5] );
hold off;

sigma = [1   0.9; ...
         0.9   1];
R = chol(sigma);
data = repmat(mu, 1000, 1) + randn(1000,2) * R;
subplot(2,2,3);
plot(data(:,1), data(:,2), '.' );

[coefs,scores,variances] = pca( data );
hold on;
plot( [0, coefs(1,1)], [0, coefs(2,1)], 'r-', 'LineWidth', 2 );
plot( [0, coefs(1,2)], [0, coefs(2,2)], 'r-', 'LineWidth', 2 );
title( ['cov = 0.9, lamda_1 = ', num2str(variances(1)), ', lamda_2 = ', num2str(variances(2))] );
axis( [-4.5, 4.5, -4.5 4.5] );
hold off;

sigma = [1   0.999; ...
         0.999   1];
R = chol(sigma);
data = repmat(mu, 1000, 1) + randn(1000,2) * R;
subplot(2,2,4);
plot(data(:,1), data(:,2), '.' );

[coefs,scores,variances] = pca( data );
hold on;
plot( [0, coefs(1,1)], [0, coefs(2,1)], 'r-', 'LineWidth', 2 );
plot( [0, coefs(1,2)], [0, coefs(2,2)], 'r-', 'LineWidth', 2 );
title( ['cov = 0.999, lamda_1 = ', num2str(variances(1)), ', lamda_2 = ', num2str(variances(2))] );
axis( [-4.5, 4.5, -4.5 4.5] );
hold off;

%% Demo 2
% simulate data
figure; 
mu = [0 0];
sigma = [1   0; 0   1];
R = chol(sigma);
data = repmat(mu, 1000, 1) + randn(1000,2) * R;
data(:,3) = data(:,1) + rand(1000,1)*0.05;
plot3(data(:,1), data(:,2), data(:,3), '.' );
grid on;
xlabel( 'x' ); ylabel('y'); zlabel('z');

%
[pc_vec, ~, variances] = pca( data );

plot3(data(:,1), data(:,2), data(:,3), 'o' );
hold on;
for k = 1 : 3
    temp = pc_vec(:,k) * sqrt(variances(k)) * 3;
    quiver3( 0, 0, 0, temp(1), temp(2), temp(3), 'LineWidth', 3 );
end
grid on;


%% Demo -- cities
load cities;
boxplot( ratings, 'orientation', 'horizontal', 'labels', categories );

% some preprocessing
stdr = std(ratings);
sr = ratings./repmat(stdr,329,1);

%%
[eigenvectors,scores,variances] = pca(sr);
figure; 
plot( scores(:,1), scores(:,2), '+' );
xlabel( '1st Principal Component' );
ylabel( '2nd Principal Component' );
gname(names);
