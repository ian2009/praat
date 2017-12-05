# test_Ltas_reportSpectralTilt.praat
# djmw 20130813, 2017

appendInfoLine: "test_Ltas_reportSpectralTilt"
@ltas
procedure ltas
	s[1] = Create Sound from formula: "sineWithNoise", 1, 0, 1, 44100, "randomGauss(0,0.1)"
	s[2] = Filter (de-emphasis): 50
	# some of the following values are rough guesses, if the assertion failes adapt the values somewhat
	slope[1] = 0 ; dB/Hz (this value is exact)
	slopemargin[1] = 0.5 ; approximate
	slope[2] = -20 ; dB/decade (this value is exact)
	slopemargin[2] = 1.5 ; approximate
	offset[1] = 30.8 ; dB approximate
	offsetmargin[1] = 3 ; approximate
	offset[2] = 95 ; dB ; approximate
	offsetmargin[2] = 4 ; approximate
	for i to 2
		selectObject: s[i]
		ltas = To Ltas: 100
		info$ = Report spectral tilt: 100, 10000, "Logarithmic", "Robust"
		slope =  extractNumber (info$, "Slope:")
		offset = extractNumber (info$, "Offset:")
		slopediffr = (slope - slope [1]) / slope [1]
		offsetdiffr = (offset - offset [1]) / offset
		appendInfoLine: tab$, "r. slopediff= ", percent$ (slopediffr, 1), "; Offset= ", fixed$ (offsetdiffr, 1)
		assert slope > (slope[i] - slopemargin[i]) and slope < (slope[i] + slopemargin[i])
		assert offset > (offset[i] - offsetmargin[i]) and offset < (offset[i] + offsetmargin[i])
		removeObject: s[i], ltas
	endfor
endproc
appendInfoLine ("test_Ltas_reportSpectralTilt OK")
