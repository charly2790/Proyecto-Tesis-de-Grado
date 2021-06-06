function [X_norm, mu, sigma] = featureNormalize(X)

X_norm = X;
mu = zeros(1, size(X, 2));

sigma = zeros(1, size(X, 2));

num_elements = size(X,2);

  for iter=1:num_elements
         
    mu(iter) = mean(X_norm(:,iter));
    sigma(iter) = std(X_norm(:,iter));
    
    X_norm(:,iter)=(X_norm(:,iter)-mu(iter))./sigma(iter);
    
  end

end
