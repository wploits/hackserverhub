local Utilities = {}
function Utilities.IsDescendantOf(child, parent)
    while child do
        if child == parent then
            return true
        end
        child = child.Parent
    end
    return false
end
function Utilities.GetDescendant(parent, name, className)
    for _, descendant in pairs(parent:GetDescendants()) do
        if descendant.Name == name and descendant:IsA(className) then
            return descendant
        end
    end
    return nil
end

function Utilities.GetAncestor(child, name, className)
    local current = child.Parent
    while current do
        if current.Name == name and current:IsA(className) then
            return current
        end
        current = current.Parent
    end
    return nil
end
function Utilities.FindFirstAncestorOfType(child, className)
    local current = child.Parent
    while current do
        if current:IsA(className) then
            return current
        end
        current = current.Parent
    end
    return nil
end
function Utilities.GetChildrenByType(parent, className)
    local children = {}
    for _, child in pairs(parent:GetChildren()) do
        if child:IsA(className) then
            table.insert(children, child)
        end
    end
    return children
end

function Utilities.GetDescendantsByType(parent, className)
    local descendants = {}
    for _, descendant in pairs(parent:GetDescendants()) do
        if descendant:IsA(className) then
            table.insert(descendants, descendant)
        end
    end
    return descendants
end
function Utilities.HasAttribute(instance, attributeName)
    return instance:GetAttribute(attributeName) ~= nil
end

function Utilities.GetAttributeOrDefault(instance, attributeName, defaultValue)
    local value = instance:GetAttribute(attributeName)
    if value ~= nil then
        return value
    else
        return defaultValue
    end
end
function Utilities.CloneInstance(instance, newParent)
    local clone = instance:Clone()
    clone.Parent = newParent
    return clone
end
function Utilities.WaitForChildOfType(parent, className, timeout)
    local child = parent:FindFirstChildOfClass(className)
    if child then
        return child
    end
    
    local startTime = tick()
    while tick() - startTime < (timeout or 5) do
        child = parent:FindFirstChildOfClass(className)
        if child then
            return child
        end
        wait(0.1)
    end
    return nil
end
function Utilities.IsPointInPart(part, point)
    local size = part.Size
    local position = part.Position
    local minBound = position - size / 2
    local maxBound = position + size / 2
    
    return (point.X > minBound.X and point.X < maxBound.X) and
           (point.Y > minBound.Y and point.Y < maxBound.Y) and
           (point.Z > minBound.Z and point.Z < maxBound.Z)
end
function Utilities.GetDistance(pointA, pointB)
    return (pointA - pointB).Magnitude
end

function Utilities.GetAngleBetweenVectors(vectorA, vectorB)
    return math.acos(vectorA:Dot(vectorB) / (vectorA.Magnitude * vectorB.Magnitude))
end
function Utilities.RotateVectorY(vector, angle)
    local cos = math.cos(angle)
    local sin = math.sin(angle)
    return Vector3.new(
        cos * vector.X - sin * vector.Z,
        vector.Y,
        sin * vector.X + cos * vector.Z
    )
end
function Utilities.GetSurroundingVectors(target, radius, amount, offset)
    radius = radius or 5
    amount = amount or 8
    offset = offset or 0

    local positions = {}
    local angleIncrement = (2 * math.pi) / amount
    local adjustedOffset = offset / radius -- Adjust the offset relative to the circle's size

    for i = 1, amount do
        local angle = angleIncrement * i + adjustedOffset
        local x = target.X + radius * math.cos(angle)
        local z = target.Z + radius * math.sin(angle)
        table.insert(positions, Vector3.new(x, target.Y, z))
    end

    return positions
end



return Utilities
