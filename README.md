zadania 1,2 i 3.

-----------------------------zad 1---------------------------------------------------------------
Hello,

Dziekujemy za nadeslanie rozwiazania pierwszego zadania. Zadanie wykonane dobrze, jedyna uwaga dotyczy uzycia protokolow. W tym przypadku definiowanie protokolow jest nadmiarowe, skoro tylko jedna klasa/struktura implementuje kazdy z protokolow oraz nigdzie protokol nie jest jawnie uzywany.

Gratulacje i witamy w drugiej turze. Juz za chwile dolaczymy Cie do grupy na google, na ktorej bedziemy kontynuowali dyskusje zwiazane z tegorocznym projektem Patronage i gdzie pojawi sie zadanie numer 2.

Br,
Sebastian
----------------------------zad 2----------------------------------------------------------------
Hej,

Zadanie wykonane bardzo dobrze 5/5

Gratuluję i witamy w kolejnym etapie 
-----------------------------zad 3 ---------------------------------------------------------------
Hello,

Dziekujemy za nadeslanie rozwiazania zadania numer 3. Ponizej znajdziesz uwagi do nadeslanego kodu. Niestety jakosc nadeslanego rozwiazania nie pozwala nam na zaproszenie Cie do glownego etapu programu Patronage 2015. Dziekujemy za probe i zapraszamy ponownie za rok.

Uwagi:
- funkcja haversine nie potrzebnie przeniesiona na zewnatrz struktury Coordinate. 
- funkcja haversine jest blednie zaimplementowana. Odleglosc np. do MakKwak wynosi u Ciebie 228m... a powinna wyjść 139,5m. 
- przez użycie symboli zamiast nazw zmiennych w metodzie haversine stała się ona kompletnie nieczytelna. Powinieneś pokusić się o skomentowanie co jest czym.
- Po przefiltrowaniu powinny zostać zwrócone punkty MakKwak oraz CH Kaskada, zwrócony został jeden punkt przez niepoprawnie zaimplementowaną metodę haversine.
- W closure do metody filter uzywasz takiego kodu:

return (Coordinate.distanceBetweenCoordinates(point.coordinates, bCoordinate: importantPoints[0].coordinates) < rangeInMeters.convertMetersTo(.kilometers) && point.name != importantPoints[0].name)

A co jesli pod indexem zero nie bedzie adresu biura BLStream?

Po poprawieniu nazw twojej metody od razu widać co było nie tak w jej implementacji. Poprawiona metoda poniżej.

func haversine(aLatitude:Double,bLatitude:Double,aLongitude:Double,bLongitude:Double) -> Double {
var d = 0.0

var radianLatitude = (bLatitude-aLatitude).deg2rad()
var radianLongitude = (bLongitude-aLongitude).deg2rad()
var aLatitudeRad = aLatitude.deg2rad()
var bLatitudeRad = bLatitude.deg2rad()

var a = pow(sin(radianLatitude/2.0),2) + cos(aLatitudeRad)*cos(bLatitudeRad) * pow(sin(radianLongitude/2.0),2)

let c = 2.0 * atan2(sqrt(a), sqrt(1.0 - a))

d = c * 6371
return d * 1000
}


Br,
Sebastian