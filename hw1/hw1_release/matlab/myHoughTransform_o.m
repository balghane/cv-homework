function [H, rhoScale, thetaScale] = myHoughTransform_o(Im, threshold, rhoRes, thetaRes)
%Your implementation here
%Im - grayscale image - 
%threshold - prevents low gradient magnitude points from being included
%rhoRes - resolution of rhos - scalar
%thetaRes - resolution of theta - scalar

[a, b] = size(Im);

rho_maxval = sqrt(a*a + b*b);
rho_bins = 2 * ceil(rho_maxval / rhoRes);
rhoScale = 1:rho_bins;
rhoScale = rhoScale * rhoRes - (rhoRes / 2)*(rho_bins+1);

theta_maxval = pi;
theta_bins = ceil(theta_maxval / thetaRes);
thetaScale = 1:theta_bins;
thetaScale = thetaScale * thetaRes - thetaRes / 2;

%cosines = cos(thetaScale);

H = zeros([theta_bins, rho_bins]);

for k = 1:a*b
%for k = 1920:3840
    [i, j] = ind2sub([a, b], k);
    if Im(i,j) > threshold
        mag = sqrt(i*i + j*j);
        phase = atan(-j/i);
        shifted_cosine = mag*cos(-thetaScale + phase + pi / 2);
        %shift = round(phase / thetaRes);
        %shifted_cosine = circshift(cosines * mag, -shift);
        % indices = round((shifted_cosine / rhoRes) + 0.5, 0) + rho_bins / 2;
        % to use indices, have to flatten H
        
        for z = 1:theta_bins
            rho_bin_index = round(shifted_cosine(z) / rhoRes + 0.5, 0) + rho_bins / 2;
            %this_val
            %rho_bin_index
            %thetaScale(z)
            %mag
            %phase
            %rho_bins
            %rhoScale
            %rho_maxval
            H(z,rho_bin_index) = H(z,rho_bin_index) + 1;
        end
    end
end

H = H';
[H_hough,theta_hough,rho_hough] = hough(Im > threshold,'RhoResolution',rhoRes,'ThetaResolution',thetaRes * 180 / pi);

size(H)
size(H_hough)

%RI = imref2d(size(H));
%RI.XWorldLimits = [thetaScale(1), thetaScale(theta_bins)];
%RI.YWorldLimits = [rhoScale(1), rhoScale(rho_bins)];

imshow(rescale(H), [0 0.5])
%figure, imshow(hough(Im(3:4,:) > threshold,'RhoResolution',rhoRes,'ThetaResolution',thetaRes), [0 10])
figure, imshow(rescale(H_hough), [0 0.5])

end
        
        
