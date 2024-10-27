import pyoptinterface as poi
from pyoptinterface import highs

model = highs.Model()

x = model.add_variable(lb=0, ub=1, domain=poi.VariableDomain.Continuous, name="x")
y = model.add_variable(lb=0, ub=1, domain=poi.VariableDomain.Integer, name="y")

con = model.add_linear_constraint(x+y, poi.Geq, 1.2, name="con")

obj = 2*x
model.set_objective(obj, poi.ObjectiveSense.Minimize)

model.set_model_attribute(poi.ModelAttribute.Silent, False)
model.optimize()

print(model.get_model_attribute(poi.ModelAttribute.TerminationStatus))
# TerminationStatusCode.OPTIMAL

x_val = model.get_value(x)
# 0.2

y_val = model.get_value(y)
# 1.0
print(x_val, y_val)