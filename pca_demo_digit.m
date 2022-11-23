%% PCA demo -- digit
clear
fid = fopen( 't10k-images.idx3-ubyte', 'r' );
data = fread( fid, 'uint8' );
fclose(fid);
data = data(17:end);
data = reshape( data, 28*28, 10000 )';

fid = fopen( 't10k-labels.idx1-ubyte', 'r' );
label = fread( fid, 'uint8' );
fclose(fid);
label = label(9:end);

% id = 10;
% img = data(id, :) ;
% imshow( reshape(img, 28, 28)' );
% title( num2str( label(id) ) );

%%
aDigitSet = data(label==3, :);
[pc_vec, pc_score, variance] = pca( aDigitSet );
temp = cumsum( variance );
plot( temp / max(temp) );

%% Mean and First 99 Principal Vectors
img = ones( 28 * 10 + 9, 28 * 10 + 9 ) * min(min(pc_vec(:, 1:100)));
meanV = mean( data(label==3, :) )';
temp = meanV / max(meanV(:)) * max(max(pc_vec(:, 1:100)));
img(1:28, 1:28) = reshape( temp, 28, 28 )';
rs = 1:28;
vecIdx = 0;
for r = 1 : 10
    if r == 1
        cs = (1 : 28) + 29;
    else
        cs = 1 : 28;
    end
    for c = 1 : 10
        vecIdx = vecIdx + 1;
        img(rs, cs) = reshape( pc_vec(:, vecIdx), 28, 28 )';
        cs = cs + 29;
        if r == 1 && c == 9
            break;
        end
    end
    rs = rs + 29;
end
figure; imshow( img, [] );

%%
coeff = [-950, 0, 0]';
temp = meanV + pc_vec(:, 1:3) * coeff;
figure; 
subplot(1,5,1); imshow( img(1:28, 1:28), [] ); title('Mean')
subplot(1,5,2); imshow( img(1:28, (1:28)+29), [] ); title('PC1')
subplot(1,5,3); imshow( img(1:28, (1:28)+58), [] ); title('PC2')
subplot(1,5,4); imshow( img(1:28, (1:28)+87), [] ); title('PC2')
subplot(1,5,5); imshow( reshape(temp, 28, 28)', [] ); 
title( ['Mean + ', num2str(coeff(1)), '*v1 + ', num2str(coeff(2)), '*v2 + ', num2str(coeff(3)), '*v3'] );
