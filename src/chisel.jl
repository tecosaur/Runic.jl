# SPDX-License-Identifier: MIT

function is_leaf(node::JuliaSyntax.GreenNode)
    return !JuliaSyntax.haschildren(node)
end

function first_leaf(node::JuliaSyntax.GreenNode)
    if is_leaf(node)
        return node
    else
        return first_leaf(first(JuliaSyntax.children(node)::AbstractVector))
    end
end

function last_leaf(node::JuliaSyntax.GreenNode)
    if is_leaf(node)
        return node
    else
        return last_leaf(last(JuliaSyntax.children(node)::AbstractVector))
    end
end

function is_assignment(node::JuliaSyntax.GreenNode)
    return JuliaSyntax.is_prec_assignment(node)
end
function is_infix_op_call(node::JuliaSyntax.GreenNode)
    return JuliaSyntax.kind(node) === K"call" &&
        JuliaSyntax.is_infix_op_call(node)
end
function is_comparison_leaf(node::JuliaSyntax.GreenNode)
    return is_leaf(node) && JuliaSyntax.is_prec_comparison(node)
end
function is_operator_leaf(node::JuliaSyntax.GreenNode)
    return is_leaf(node) && JuliaSyntax.is_operator(node)
end
