# first batch maps refined verb codes to p="y", p="n" only
s/ 208/ 200/;
s/ 209/ 201/;
s/ 211/ 203/;
s/ 212/ 204/;
s/ 213/ 205/;
s/ 214/ 206/;
s/ 215/ 207/;
s/ 216/ 200/;
s/ 217/ 201/;
s/ 219/ 203/;
s/ 220/ 204/;
s/ 221/ 205/;
s/ 222/ 206/;
s/ 223/ 207/;
s/ 232/ 200/;
s/ 233/ 201/;
s/ 235/ 203/;
s/ 236/ 204/;
s/ 237/ 205/;
s/ 238/ 206/;
s/ 239/ 207/;
s/ 240/ 200/;
s/ 241/ 201/;
s/ 243/ 203/;
s/ 244/ 204/;
s/ 245/ 205/;
s/ 246/ 206/;
s/ 247/ 207/;
s/ 248/ 200/;
s/ 249/ 201/;
s/ 251/ 203/;
s/ 252/ 204/;
s/ 253/ 205/;
s/ 254/ 206/;
s/ 255/ 207/;
# Next datives...
s/^(hathláimh) 66$/$1 67/;
s/^((?:n-|[bmd]')?athláimh) 6[46]$/$1 65/;
s/^(m?bh?anláimh) 64$/$1 65/;
s/^(m?bh?ois) 64$/$1 65/;
s/^(m?bh?róig) 64$/$1 65/;
s/^(g?ch?eathrúin) 64$/$1 65/;
s/^(g?ch?éill) 64$/$1 65/;
s/^(g?ch?éin) 64$/$1 65/;
s/^(g?ch?ionn) 64$/$1 65/;
s/^(g?ch?luais) 64$/$1 65/;
s/^(g?ch?ois) 64$/$1 65/;
s/^(g?ch?rích) 64$/$1 65/;
s/^(n?dh?easláimh) 64$/$1 65/;
s/^(héill) 66$/$1 67/;
s/^((?:n-|[bmd]')?éill) 6[46]$/$1 65/;
s/^(hÉirinn) 66$/$1 67/;
s/^((?:n|[bmd]')?Éirinn) 6[46]$/$1 65/;
s/^((?:bh)?fh?eirg) 64$/$1 65/;
s/^((?:bh)?fh?ichid) 64$/$1 65/;
s/^(n?gh?réin) 64$/$1 65/;
s/^(láimh) 64$/$1 65/;
s/^(leathchois) 64$/$1 65/;
s/^(leathláimh) 64$/$1 65/;
s/^(leith) 64$/$1 65/;
s/^(niomh) 64$/$1 65/;
s/^(b?ph?éin) 64$/$1 65/;
s/^(d?th?igh) 64$/$1 65/;
s/^(d?th?oinn) 64$/$1 65/;
s/^(g?ch?ianaibh) 96$/$1 97/;
s/^(hiaróibh) 98$/$1 99/;
s/^((?:n-|[bmd]')?iaróibh) 9[68]$/$1 97/;
s/^(huai[nr]ibh) 98$/$1 99/;
s/^((?:n-|[bmd]')?uai[nr]ibh) 9[68]$/$1 97/;
# leave out capitals...
s/^(huíbh) 98$/$1 99/;
s/^((?:n-|[bmd]')?uíbh) 9[68]$/$1 97/;
s/^(hUltaibh) 98$/$1 99/;
s/^((?:n|[bmd]')?Ultaibh) 9[68]$/$1 97/;
#  autonomous imperative is very rare.  It does exist though, see OF81
#  for several examples:  Ná hitear...  etc.
#  The only ones that are unambiguous are the ones with initial "h",
#  all others will resort (sensibly) to the present autonomous
s/^([^ ]+) 192$/$1 127/;
#  same for pres. subjunctive autonomous; only unambiguous ones are
#  "rabhthar" and "dheirtear".  The first is used as an alt of "rabhthas"
#  and the second is incorrectly lenited after "ní" in the present
#  All other cases will default to present
s/^([^ ]+) 199$/$1 127/;
# now fix some to 127; these are mostly inflected forms
# that happen to nearly coincide with something common, like
# "airithe" for "áirithe"; but for which it's not acceptable
# to mark the headword (verb "airigh (feel, perceive)") as OD77b or whatever.
#    DON'T BOTHER DOING THIS TO SUBJUNCTIVES (m.sh. "bhfeile" for "bhféile")
#    OR OTHER WORDS FOR WHICH A CLEARER ERROR MESSAGE ALREADY EXISTS
#    like "hait/háit" where the NIAITCH rules will surely apply
s/^(aireofar) .*/$1 127/;
s/^(h?airithe) .*/$1 127/;
s/^(h?aiseanna) .*/$1 127/;
s/^(anais) .*/$1 127/;
s/^(ata) .*/$1 127/;
s/^(ataim) .*/$1 127/;
s/^(ataimid) .*/$1 127/;
s/^(banaithe) .*/$1 127/;
s/^(beith) .*/$1 127/;
s/^(bhanaithe) .*/$1 127/;
s/^(bhfainne) .*/$1 127/;
s/^(bhfalta) .*/$1 127/;
s/^(bhfasach) .*/$1 127/;
s/^(bhfeilte) .*/$1 127/;
s/^(bhformaid) .*/$1 127/;
# all errors in corpus
s/^(brach) .*/$1 127/;
s/^(g?ch?arta) .*/$1 127/;
s/^(g?ch?ais) .*/$1 127/;
s/^(cheanna) .*/$1 127/;
s/^(chlaimh) .*/$1 127/;
s/^(chlois) .*/$1 127/;
s/^(g?ch?oip) .*/$1 127/;
s/^(choirigh) .*/$1 127/;
s/^(claimh) .*/$1 127/;
s/^(g?ch?ritear) .*/$1 127/;
s/^(cruibe) .*/$1 127/;
s/^(d'ait) .*/$1 127/;
s/^(n?dearfaidh) .*/$1 127/;
s/^(dearfaimid) .*/$1 127/;
s/^(n?dearfar) .*/$1 127/;
s/^(deirceach) .*/$1 127/;
s/^(d'eisc) .*/$1 127/;
s/^(d'fhail) .*/$1 127/;
s/^(d'fhaisc) .*/$1 127/;
s/^(d'fheilte) .*/$1 127/;
s/^(dtairgeadh) .*/$1 127/;
s/^(dteann) .*/$1 127/;
s/^(dtoin) .*/$1 127/;
s/^(dtoir) .*/$1 127/;
s/^(h?eisc) .*/$1 127/;
s/^(falta) .*/$1 127/;
s/^(fhainne) .*/$1 127/;
s/^(fhalta) .*/$1 127/;
s/^(fhasach) .*/$1 127/;
s/^(fheilte) .*/$1 127/;
#  ok in lowercase but "Fhinne" is common enough in place names
# s/^(fhinne) .*/$1 127/;
s/^(fh?irinne) .*/$1 127/;
s/^(fhormaid) .*/$1 127/;
s/^(fhrasa) .*/$1 127/;
s/^(gair) .*/$1 127/;
# all errors in corpus
s/^(gceanna) .*/$1 127/;
s/^(ghala) .*/$1 127/;
s/^(gheire) .*/$1 127/;
s/^(hairce) .*/$1 127/;
s/^(haite) .*/$1 127/;
s/^(inne) .*/$1 127/;
s/^(iosta) .*/$1 127/;
s/^(leannta) .*/$1 127/;
s/^(l[eé]ithe) .*/$1 127/;
s/^(litear) .*/$1 127/;
s/^(luide) .*/$1 127/;
s/^(m'ait) .*/$1 127/;
s/^(mbeith) .*/$1 127/;
s/^(n-aireofar) .*/$1 127/;
s/^(n-aiseanna) .*/$1 127/;
s/^(n-ait) .*/$1 127/;
s/^(ndearfadh) .*/$1 127/;
s/^(ndearfainn) .*/$1 127/;
s/^(ndein) .*/$1 127/;
s/^(ngabhail) .*/$1 127/;
s/^(ngeire) .*/$1 127/;
s/^(phice) .*/$1 127/;
s/^(prais) .*/$1 127/;
s/^(saile) .*/$1 127/;
s/^(sceimhe) .*/$1 127/;
s/^(seire) .*/$1 127/;
s/^(sheala) .*/$1 127/;
s/^(sheid) .*/$1 127/;
s/^(Shile) .*/$1 127/;
s/^(shilfeadh) .*/$1 127/;
s/^(sh?ilim) .*/$1 127/;
s/^(sh?iltear) .*/$1 127/;
s/^(spaide) .*/$1 127/;
s/^(speire?) .*/$1 127/;
s/^(stileanna) .*/$1 127/;
s/^(stile) .*/$1 127/;
s/^(thairgeadh) .*/$1 127/;
s/^(th?eitear) .*/$1 127/;
s/^(theite) .*/$1 127/;
s/^(thoin) .*/$1 127/;
s/^(tseala) .*/$1 127/;
