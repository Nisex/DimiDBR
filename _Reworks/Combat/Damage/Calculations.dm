
proc/getFlowCalc(base = 6, flow = 0, inst = 0)
    var/result = 0
    if(inst)
        result = base + flow - inst
    else
        result = base + flow
    return result


/*
flow gives a % chancce to avoid a blow, and is negated by their instinct
given this if flow is = to instinct, then the chance to avoid is nothing (0.5 - 0.5 = 0)
what we need is something that multiplies the base chance of 6 by the amount of flow they have
this flow that they have should be affected by their instinct
*/			