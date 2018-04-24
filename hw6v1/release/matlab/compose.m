function ret_vars = compose(vars,dvars)

ret_vars = [vars(1) + dvars(1) + vars(1)*dvars(1) + vars(3)*dvars(2) ...
            vars(2) + dvars(2) + vars(2)*dvars(1) + vars(4)*dvars(2) ...
            vars(3) + dvars(3) + vars(1)*dvars(3) + vars(3)*dvars(4) ...
            vars(4) + dvars(4) + vars(2)*dvars(3) + vars(4)*dvars(4) ...
            vars(5) + dvars(5) + vars(1)*dvars(5) + vars(3)*dvars(6) ...
            vars(6) + dvars(6) + vars(2)*dvars(5) + vars(4)*dvars(6) ...
            ];

end

