const Engine="groo-ga.bat"
const TempFileName="GrOOo.sxw"

sub callGramadoir

oPathSubst = createUnoService("com.sun.star.util.PathSubstitution")
TempDir = oPathSubst.getSubstituteVariableValue("$(temp)")
tempURL=TempDir & "/" & TempFileName
myURL=ThisComponent.getLocation()
shellcommand=Engine
param=Chr(34) & convertFromURL(myURL) & Chr(34) & " " & Chr(34) & convertFromURL(tempURL) & Chr(34)
Shell(shellcommand,2,param,true)

dim NoArgs()
theDoc=StarDesktop.loadComponentfromURL(tempURL,"_blank",0,noArgs())

end sub
