function [composite_img] = compositeH(H2to1, template, img)

img_warped = warpH(img, H2to1, size(template));
template(img_warped > 0) = 0;
composite_img = img_warped + template;

end

