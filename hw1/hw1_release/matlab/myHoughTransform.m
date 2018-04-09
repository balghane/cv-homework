function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
%Im - grayscale image - 
%threshold - prevents low gradient magnitude points from being included
%rhoRes - resolution of rhos - scalar
%thetaRes - resolution of theta - scalar

[a, b] = size(Im);

rho_maxval = sqrt(a*a + b*b);
rho_bins = 2 * ceil(rho_maxval / rhoRes) + 1;
rhoScale = 1:rho_bins;
rhoScale = rhoScale * rhoRes - (rhoRes)*ceil(rho_bins / 2);

theta_maxval = pi / 2;
theta_bins = 2 * ceil(theta_maxval / thetaRes);
thetaScale = 1:theta_bins;
thetaScale = thetaScale * thetaRes - (thetaRes / 2) * (theta_bins+1);

%cosines = cos(thetaScale);

H = zeros([theta_bins, rho_bins]);

for k = 1:a*b
%for k = 1920:3840
    [i, j] = ind2sub([a, b], k);
    if Im(i,j) > threshold
        mag = sqrt(i*i + j*j);
        phase = atan(-j/i);
        shifted_cosine = mag*cos(-thetaScale + phase + pi/2);
        %shift = round(phase / thetaRes);
        %shifted_cosine = circshift(cosines * mag, -shift);
        % indices = round((shifted_cosine / rhoRes) + 0.5, 0) + rho_bins / 2;
        % to use indices, have to flatten H
        
        for z = 1:theta_bins
            rho_bin_index = round(shifted_cosine(z) / rhoRes, 0) + ceil(rho_bins / 2);
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

%size(H)
%size(H_hough)

%thetaScale * 180/pi
%theta_hough

%rhoScale(1:10)
%rho_hough(1:10)

%{
RI = imref2d(size(H));
RI.XWorldLimits = [180/pi*thetaScale(1), 180/pi*thetaScale(theta_bins)];
RI.YWorldLimits = [rhoScale(1), rhoScale(rho_bins)];

RI2 = imref2d(size(H_hough));
RI2.XWorldLimits = [180/pi*thetaScale(1), 180/pi*thetaScale(theta_bins)];
RI2.YWorldLimits = [rhoScale(1), rhoScale(rho_bins)];
%}

%figure, imshow(rescale(H), [0 0.5], 'InitialMagnification', 200)
%figure, imshow(hough(Im(3:4,:) > threshold,'RhoResolution',rhoRes,'ThetaResolution',thetaRes), [0 10])
%figure, imshow(rescale(H_hough), [0 0.5])

end
        
        
