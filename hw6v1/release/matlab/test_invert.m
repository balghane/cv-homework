vars = [1.1 -0.2 -0.1 0.8 5 -5];
M = make_33_from_vars(vars);
warp_form = affine2d(M);
warp_form.T
warp_form_inv = invert(warp_form);
warp_form_inv.T
inverted_vars = invert_warp_vars(vars);
M_inv_custom = make_33_from_vars(inverted_vars);
warp_form_inv_custom = affine2d(M_inv_custom);
warp_form_inv_custom.T