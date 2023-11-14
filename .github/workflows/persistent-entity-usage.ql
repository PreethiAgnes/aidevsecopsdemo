language=java
import java
import semmle.code.java.api.SpringMVC

// Query to find methods annotated with @RequestMapping that have a parameter of type Entity
from Method method, Annotation annotation, Parameter parameter, ClassOrInterfaceType entityType
where
  method.hasAnnotation(annotation) and
  annotation.getName() = "@RequestMapping" and
  method.getParameters(parameter) and
  parameter.getType().getASupertype*().hasQualifiedName("javax.persistence", "Entity") and
  entityType = parameter.getType().asClassOrInterfaceType().getBaseType()
select method, annotation, parameter, entityType, "Entity used as argument in @RequestMapping"

