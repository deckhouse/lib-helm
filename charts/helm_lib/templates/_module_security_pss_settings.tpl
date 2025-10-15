
{{- /* https://helm-playground.ru/#t=FAbxFoAIHoCpMgQUgFwIYCMA2BTSBnACwHsB3ASwDsBzSUw8gY0MgAMBhYy-FAJzSooAKjgC2AByxoUOVpGIYAVjkYpI5fJF4584rvnLY8AM2K9I4tP1E4Z5gG5os5ACbTyXAHSQhDTRshKHBwXENRiSGocIP4ZVEI8RjNtVUg0SkpidBQPSm9IWGhIcABfEtAIGHgkAFcAD3JnKwBPdUo7SidIYxrKVVyCotLysChQ4yo8ACIErFEAfWcMedFiFxrcefF8fHneDZ159CMpyDLgfBUa3nIUZs52nDqUAC5gBG00FwB5SixmgBKxCyADFGjpmjwxC9IC4AByfFxcf68YEoCa4fCQmSid5pLBYMgABRu9nBUQAovhGE53FwYfCnITSOJSeTgtTaTkuHiaZYMI1buQdAy4UyyCE%2BZhBTkdHj9pREPgAKqXXii8WkEI1NX4eW9JUAOS4QKyGoJEvWurxl0YSQkJOIGJw5uZIVt9vErKd4L1CDQXsQvFWvEdzo1XqsIZtOAAMlR6t9xNzuKLLs5KPU8azyGTcFEXKKc3mcAWku0BDFs6jGABZYi9V6wsUWrUub2MVaNm2Q1RYfCuy1Y6kofvAIIoUhmADWbwQJB4htsU94s%2BbC5QE5X07xG6JAEkACKijcdnSXP2QDf7onsE-EHhnnZy%2BcPlBEswoAfrt9bmfAexiCwGobAHXc3yJaRCEHNtTygy87nEF1m01EJAOAmxELlUZIGiFwznKYAiJwuBIFVNAohhMA2kYYDQkgGYcDmRZDBWNYDi2HZ5kuFAchofBTgAClhJg1CmW1rlue4uBkZ5TgAEh4vjqHwTwJJuO4HlktQAEoCMGYpzhI%2BAlKoFTcLqNAJFwAzhgqKBSLxBB1KkrSnibBBPK87yfN8hAnM8xFfn%2BU0UDBTFsWhVB9jwPzvIC-1WxJXN2SpGkpBTGFjCcS44v8nypQFZxZW-PKyt8hLvJcVFxBhcr6oqhqoEQWNYwa9rKq8r5C3a3qfM63yoENCkhHmAAhfdDUPeYAGUKQBAA1fd2ApXrKoVJVVRwdVIAARgABkOvq8vWg18AAcVRGpasgABmQ79uOvzTsVfBjUoUKYT4GpYqezzKoDcQgxDMNwRhBUchsaBxjQDY1DiyqPWIB1UXDP7GrirCYQBRtyBsQ8cGyuHjsq4t2R67L%2B1%2B9HIFJmt60bGECaJrB4ZpxHe1HUqaZOvKoE6GwYQnTxyHEewABYRfERZiHSrZPz2dIonysrHGA5CpgOgAmcXIAANgAVgN26DdONafMueNMzqJMU25nnabynVtphYccXmGoHYGj4gOQt2xD2L28qxtpbiOB2Vb83B7CY13Hoj-zCkMkZKlI7QUGuSgCCuDTpMeZ5bPOezYUJyYGNmBYljY9ZNm2XZTP404jMqCgUBYNSc9cmT3IIi5O807vnjnLQcC%2BYLATRcKIShUQXmo8hjCvNB8AAaRwVpvCmIK-gn0FfUi0Qm5KSBqM8beQsn-eZ4I6imNyspop%2B2-KHw85EuZZKS0pTkMtyOeQHUIvQgy814bwYpqT%2BqUf50koEfE%2BADPAQLZPmHAaUuQDDKLfKm%2BlKaXGfq-coCBCoymFGBLy1ViC1UqlAJkAUcIL0gJ4YhxVSGIJcAQgK3UYSVRwkwgM0oWE6DYfhAAPuEAAmlZLAkAxGUCoKEdo%2Bte5eRwnhZRWgzpbR2qfDaKo1QyJLizNQetxbGwNuo3Rl0Gw3R0WdKx10DEw2JiYsx6j6GL08MYC6V1xDqK8fYmxCD-E%2BLcZUNRb8NGvXep9eeQCQHr0YQxXR0S0RwNsVEk0aIb4ALvngB%2B30cD4PUUjFGPpcDDwQCHU%2BJTxCg1wJ4LCjjCaw1ZgxHG7Q8Y4GZi0lAR88TuMYRQF%2BZB8C21yJoCJCABnANXgkzwQykSkFGcmcZ5cII1nPH0hACyRljP0BUq86zZbnioggnZSy9ncE8HuDZOx1FTLCS-UJUBwmEPgVABhMzQGJKmGTFBLgtkWGQaWEIpzGF-JBaIwxPTug5TyW81RTyIkdgZu0MFngUUNkUWIpxrSpjdLhoC6Z8SwFTEBsDMwdScCAoeR8uJsyN7kuDJS1G4IGJYUBUykGrLymO08rwrlLKyl4DESgYgkjRDSNkfI6IahdaTPebhJFCLHkcNpYApeDKfmWwTDbFZ%2BhAU6utpcsh-LKiMKNYmfV3ADFiolVKwIMrFHypVS85V-TKgMLUpzfsxSfWmpwvwGgeBvUjl9Qq-mVlkKnwFvCyqasfrooTXG9VryPVuo4YizNqre7EVTtURA9RBQtDaB0LoPQ%2BgpkLinMYpcgjlyYpXViqwa44E4rsKIMRpBtvSJkbIuQiWVHko0l4ABeRhjS7LqvkpYawkAx3gqsFZZO6bIDyV7VkGB8wqCmHneOxBGRN0pm3ZQXdU7FXyQrixZYLaOJ1z2AcXYxwbILuMKiUQ9rICCSoLRGo9FGLMSrre2uXF9iYiOJgXApxPB6XPauz5JK11XqA%2BxEDuwwOHGfXgYdzQkL3IvRh-AIIzBCFw3gBdMq6hIcbde6ud7QOPog0YNdk6FXEq1fJQjxHeCkbwzOpdoh8PTvLDwfggg91tFCFRzjj7uO8ew7O5d56VGesXjgAAjmuxTgmZgQU-AJFdfkcLyVCNSG41qJOeEwl8aQaBPCmcYEJs1YxRJfqBYIRe4l%2B7NHsyoacJBnYi2INAfA05RbgDruAZgfnoAAFJ8DQD3J%2BOLnh9rGAUiJvglY1AYs-IaECGBtqQD0iZnQjBzNVtteKqRTnVHYIYRprTAm1k8Egm3U4ynvLGYcxVgYC6rO2Bs%2BgXz1InPqpcK54SOZ2ieZcncXzjB-MNkuEFkLYXxARZ2FFhIi24sJb3FBaA8x4vzAy-oLL4mMVQWK2unrotKuiuq5K2rYTsEKpU1AUrZn7t9fHZRtdG7%2B1cBPbunDfHtNjcVRN1IU2bgzYYnNnzoRFsBZWx4Nb4XIvRd2-Fs73ALuKJK3dizVXP3vcVWmj7Sq1UU-dVm3NxkECFoaE0XgrRBDbU6NIit-QuDVuLuMMuAGm03tQ22%2B9NheBRHmIDmBBmInGYbCgcQNQ1ALuh2oBXQ7ZdVtfe%2Bz9B6%2B0wMMxenXqy9fIwN2b-QJv1VBuVvJac68AA0a7k0SfXYeoHWdOvqoQxx63NrHcJN985tdSuVdqHHTxAHXu5drqd60QS030QMXiwAHUoLjr9-3PdG7tgn9eJXk2wfJ3V3Kofp0R9V5AaPthY-59WcH1o8l3eh-p51jvWvPvV7UI9z9dl6dF2LqRcilFFU-rotMZDzaxftpl3Hu2QkRKpC84wSSA9869LXQ3FSHd1%2B5zcgXMli-cgg%2BINBhaTgfqqUD%2Bfm70qX6ysgFrfSSdB-5uzrxMymgnhWUkHgO-s3A5PAAFIjkfh5AnJHIFKPD8DvKFFPP7LPI-NTLzN5EgilCgmgr-PSLCtgmgV5MwkKCKFAdAT5BQjdKQV5N7N5M1K1FQTQVwlQc9E1JAMNKNBNFNLNPNEtCtObN5LolojCAdEdAnC9EqAEjCPdKIUHAIWdCkmaCgbIV1IGMyqGDyshBDJ0tDM0sTAjBbCoJ6FSnVBHDQSHO0pDF0roa0n1HTJgZCllHCqYT5JiozJAASjYezBbP6iYcwXyn5JGoLIELYFLBLFLDLHLHoLwCgIrMGmQb5MmjCJrPtDrPrEbCbGbB1AYVbFanbL4TzDQc7DtEgR7Mob5KiLyiUeYAUcHGRjCFQGHGzDUXFNHLHAQPHGIUATWlUCPBnLwFnOAYPGoF0XmrWhMPWsLrRsBuLlxIHvLt0XnkemfjuhEP1nfisSusZnMRJlMB1sAXQLcO3LvqpIMVvs8j0RgV-KgtAimN4IgHaDgMmJBngMmt%2BLgjgK7k8iMdOpcVAulMburtYWoO8Ywr8VgTcQMOegMoJPWuuklMCt-P8VWu8XpGxtrqfnzhRn0FPg2oBrPq2vPp2ttN2gvo3lwEJBruAhiZQOfgpOsaehEFMBygjt5hAacL8gJuyWCSCtgTAlMKiW8j8dSZoH9tiX%2BtPjRihgSRLttNLnMRSa5ifmSbAg3ksXzkqWqdwHScKXpCbkUkXOqqRPcYwI8VhpAK8d0GYJAEQSVDCN8RemrK4OwPwkVMQZoAus4DwAxOweNJNNNHNItMtBSHsa6j0YAPgggAAiCAB8IIAEwggArCARmABcIIAAwg1pLpJCOg-Ofui8gk6Q%2BEfC-IGZmgBZAibpwiApdClQ9uIaNprC3UL2dKgQWQX6MyiSreTgTp6Zgi%2BAFZPkWx1JEmk%2B4puJIudGaG8wRJsQPa1JCpq%2B9Jpg2pyp9%2BTJZG7Jpx2k7J2m7JtZOg-JDZqp3uIpNEOJkxUp9Guwkucpwps5Ykgei5mpVJypBmixh5upww-UfZOaaJGa5xaaq6acmiaoMIyIrQmQlA4AAAXttBEBaYANAEsFVgeAqE%2BE9pxmgh%2BigJRiDEQk6mNQWQIa6F20peoZDWmmMmr0WiX6uF%2BFkA%2B0vZYeL5AJopv6-6M%2Bou0pXEk5JJd5X6lJGp3utJB5W6GxK5SEa5rJQxm5nJSSgF20e535QlBezFJ5bFY5MxF5sp05T5N5j5mp953uulh5%2Blcub5D88Uqa7q-58AySmSWQdxDxTxzGrxX0MUWZBG8htlau46BSepqmmq3ym8NlH0qS%2BGaFHlwVzZ%2B6QVoUv57q2ZX6sJ0VWSBSFZlZn2geg5YprFkp%2BJ55E50QxJMgpJelvFip85F%2BilyxDJ7Kq5LJB%2BXcW%2BUl1g7JSVWQ8lgppuwptex5w5p5uV45l5WlmpBmgkfFPFjFVa-Fcuxldsplx8-0FlHCVl2cdoyMtSGh9lJpjlNkzlbSuM%2BMQJpwqFfluZTy%2B%2BRhGhCVeAo1QJe1HSB1Ri0GNSVKDSZGekUwFhnSHhvSOk9FQpypmVLFEpeJ7FeVXFRVPFo1ZV1JglE1VVu6ol1KdVG%2BecG5DEW5dVF1wq7VaVlVNuylvVql0x8%2Bg1xVRlpVc5M5eNWcU1S%2B1NPZCA75C1tOS1hp8AEKBYm1ppzx5p1%2BJB7xnxKFQw3eWmCJYQr6ThUJflXycy6NYtAKoVQ6HNYQ%2B6ytNOQ%2BJFOZsJateBlwf1nVANWJQNI5Uxc%2B964NQ13uOltN8NFVcNwOIlzJa%2BKNbJ6N0lvy8tONVO9tNqBN2VINalJNmlZN01FNt5VNPthlodPtDNyc1Bi1uabNQKssqKKAXN21LxfN34%2BKh1gtbl0J9aN1WFOdj14K9MWKKA7131XtYeQ5-to5xN5tBVU5IdKY1t5VM1ttNVYlyNh%2BklbtzVctKdFdNdGtRESdlqeqBex1jZHcORU9qyClikTEuq8mEmuKYkT1cYuqJqr1eGneQ6jpLgc0898m7p46npYk5Y6AkwvARw25MklY20J6jRD9FYt98w049gCw2%2BUw19T9d90Q1Akw992FtuE%2BWtzZgkrZy9GY9Qa97Zzgx9FIp9ZGPZ%2Bt-1D5RtKlOVoN45FtrdA6YdUdx6KxndDt1ViN4l9Vm%2BaNHJg9Xm89JqNd3t2xftwNDdZtXEpN8pxDNt5J1NJD4y5D3Ac18dYelOLNidiqpEgq6hwq%2BdfliCqh3KCjS9cjVKa9mFMKuxoJKjQqzoe9eAB9n2R9GjGhZ9Eml9Ml91OAOhpdUwhI6UG4cA7JIZuNDCMJUDMD5jwqCDZj%2Bj8jzoZ9v1%2B5kd2DhNuDgdTdXaENVNUNlNS5ZD1Ny5Tt657kTVVkXJgTVKLDDFbDPV9dptHFGlUultodCT4dypIjQjBq9NYjzNCdItf5E9-qijs9w4fYEyHVxmGgiA1JS4IQ4t46IJJjAOrYIQM0bTHpGgYkTu-RTEakhACwwYrg8wpgvAJpCtUwwsosYRosERTg8s0RsRUQ7JuzYsksBzvQatxzMRPAVgv9FzYRKAjA0sWIfQwIYWu5DEzzks4gZkE5PipzSNOzIRezVz0sTjRz2gaoMcLgdzBmYLadELDSbzn9wQlgzgMcRwnS5z4LlzaL0s4xuLNgSu%2BLKLhLrz0sTujxHZOLgg9gWAFLoRks1LGLdL2L4uqIhWBmYz1ZFqbTZeJ1eZjCsaCV3jy8YrUa4zbox9-qv1GDDFfTAzwQoQ%2BE3lrlwrP5Clkj8V8kKrypgz6rYTGVETRTZ5%2BDzd3F8TY1MNyTPtqTtVztfdjVA9WTCO-qeTmDh53VddHDxTeVPD15fD41GV-DWp9TjNZl0BY9TT3RaaOErcRxtgykqkf4q45xXqG4S4k4M4prA55rAblr6l%2BVsT5Tbdob9rDJIjTrPdyL24mTh8LWKAubjbSr-ZT5frWVxb-Vpbwb2lVb1TgjEbz5cxc1q6kjAy1yEER4Bbht7DJtJbhJ1rcTw7lTtTNJDr5V3doLGb04Tb7Je4R43rBtw13bxtfVeD-bwdvDG7EbNTo7IjsdUtOrmtjC14t487WDi7V70TnFq7FbRD97HdKTjtzr%2B7h7LbN47Ap7nb57v7RNXDpTV5g7IHEd4bvDMdE78b8GHiSW0R3TPCVZSsIaBHX4kO8HBlRbS7fbK75bhDAj6HSTNbYHlDTtkH7rzbumrW%2Bmm5eWBWclH7em0RDE1mbg6A0G4ntmSrPr8eiHUTjd3Dt7IbzHJVkdT7Ub4DuHuHY9SbhxFqqbP%2Bng6EIEmZIt2bEE122rWgpHwnrW1nHVrDhbCnAdSnHagHjHKpanAl271bCNTtpnoEUHPH74UEUl7Wi6bcYng2EnaAUnsXMnlH6JXbrnnDJTKwKnaHdrw7GnWH470bTnUjzTdOX5hE1EMdCAMbxcf5FQhTvb178%2Bxxl%2BWdHc3%2B-Evc4AXXwAcxbw9CPbtHjX96d7K%2BYkzXjCV%2B6sJxRnHXEbglngk3N%2Bhump9%2Bekj%2BCiagr%2BZQQAA&v=LQhQGcFMBdoSwHYHNwC5QAIsagYwK4BOc0AngMID2C0kAHtKtsy6285m4ZAIYAmAeQQAbUgCVKlaADE4wyOFLhaAWybRC%2BSOxadWPYcMoB3AArEAbnMhJIAUXC4DPeNSYAzA1B0Y9LJwAOPABGciRwCkw%2B0ax%2B7HyElAFRMam6aVjAGACCADK5GalxbPx86IVZAHJ2ACoA%2BgBCAJKVACJ1AMp2YgBqTeR22MVYmgjZ4ACqUIRMAIwADIuFPsMYo%2BMA4on4yRgAzIvzy%2Byr6%2BCV1BJS6praxxzsPAEB2YQqlITmlO7W5dFkAUgTCMTmEAAtKMoAPQAKlWIIMEOUXx%2B8iYAGsABzgYBPIJvD7Aeg8FQBeTAPiQBCkYDGYi0NirPC4SiklG-e6MmIAoEYMT4GhwFSQVqQTz4YTQZarAKWay2MoYTzCbycobsWWUXAAWUoAsYGFF4slaqwTKUuGgKpSppOPiyCBJvIQMAAdHAAhYACzugJ1BHCOoBD7QOqEHjIbSrZgWAxaJgAIgWACYvRgAGwAVkze0zCcKTMguUQ%2BDoAgCrgQaFt6ui%2BGmTEUykgKjq%2BFt0ewiTROCUqjDHe5pEBTBZNB4iEghDqiBIdSlx07WHkFkgwkbRz8Lugxg%2B6L%2BrCR0EqMF3hH3GA0WlWR9MTVaHi8kBvkOgTVM5EfKuf7FvIbQqxZGO0ATi6nwhkwmLzJisydn%2BhAGrMyZ7F6madpq0BapQ64YDU5CmHaOjCiBfAuDwB7RNMVi4LyxKkuSVFwDRS7YDyTAqDwzaEMACCUJSLFYJSjgeB8GDEcQuDgBg3wYHRZKQMAjHMewQHUCBk7gQhkHQfMcGvqYEEYEhKHpuhiSYSyOF4QRXJETA-BkRRPhKbRdAkvJilTtRP6pGxYmcbQ3G8fxaRCbgImEBgY7bnA1BSZhslufRCkuX4FjYfgwrVi%2ByIuGCTlsFkQTQPlGBQrGhBQkYKACZew68q0cDcJaHykLVxEOSBBU%2BGFTDSKJ%2BLgIgSAYNV4AsaAEa8SBlYzgg7iUBReBECQFBqfQjCnAK4xTFOTAAD4sWcu2EK6LFNBgpSQHwl5gnAUk-GuN3UKISqiZS7xVhoLixQgGABEQwZQOAZ3sIEIRhPAkQYIdMRCDgrLaE2qjgAANLd2gAAbwMKdCY1F2HyC1kXcAAjvgTUKJdf2lOE1AGFFTwQ8Iq0YJjHQAJodHUNRNNqdiYyxHSQNoYKwAEaBQlCSAkGC%2BDBK6LIqFCmrEWCkD1lCwWQHU9DBghU5QsERjBOVsyugAnK6sxQmIdjZK0-OuiofAAPxkqBAC8swAMS5AA7LB7BnBcCBXAasPRCHlySNAoPRBdV03SV91KhEwjPSIpBvZFH1xd9lb-YDkIKPH%2BiGCY5hwFY8i2A4oI-W4MMsQYRhmHKtf2I4ziVmXOiJ3wlLJ3dD3p5nr0LbnLb5%2BGhcA4QQOl4WuBKwE7I9pHzmQCvrJr4kqKQH37AD0Pt2p49GfSVnOcYHnX2z79RcLyXIOrMYiB8CY4DlpW1abzo78ECf2MN-Csv1X4xBPtdM%2Bo8npXwnu9ae99G5-XnovCBbBZTV3lNdA6LEsE1xsNdI%2BbAoHD3PmPeB2dJ63yQcoB%2B1An7oJIVgTUOo9Q0DwTENhup9QsJYGQmBac4EvWoYgz69CUFMJfvwqAxYEClh-uArhlEiwljLGAuK-DmCCJTrAy%2Boib530kXPYuwNZEWitH-FiTZLQqm0dgXRI9hEGOvjQ4xBdH5oJkasPErx3ifH3hyf%2Bjxnj%2BI%2BOvQ%2B51LqD2gXolx48xFTwkZ4xh3jzFblPHubqGAjwnh3Nk5uMQ8lZPPA4rATiKEiLceImeUj0lL1-Ppe8KifC3nvOUjAlT9GJKMXQ1JqCzGNLYEed8n4inRFGR%2BTp3SElUL6Skhhgzn4ZKAA */ -}}

{{- /*  A table showing which `ConstraintTemplate` object is responsible for parameter validation. This is needed to generate the correct annotation.  */ -}}
{{- /*  Auxiliary internal function */ -}}
{{- define "helm_lib_module_pss_rules_table" }}
securityContext:
  readOnlyRootFilesystem: d8readonlyrootfilesystem
  allowPrivilegeEscalation: d8allowprivilegeescalation
  capabilities: d8allowedcapabilities
  runAsUser: d8allowedusers
  runAsNonRoot: d8allowedusers
  seccompProfile: d8allowedseccompprofiles
  appArmorProfile: d8apparmor
  seLinuxOptions: d8selinux
  privileged: d8privilegedcontainer
  procMount: d8allowedprocmount
  sysctls: d8allowedsysctls
network:
  hostNetwork: d8hostnetwork
  hostPID: d8hostprocesses
  hostIPC: d8hostprocesses
  hostPorts: d8hostnetwork
volumes:
  hostPath: d8allowedhostpaths
  type: d8allowedvolumetypes
{{- end }}



{{- /* Usage: {{ include "helm_lib_module_pss_settings" ( dict "securityContext" $settings ) }} */ -}}
{{- /* settings example */ -}}
{{- /* 
settings:
    securityContext:                             
        readOnlyRootFilesystem: true             
        allowPrivilegeEscalation: false          
        capabilities:                            
            drop:                                
                - ALL                            
            add:
                - NET_BIND_SERVICE   
        runAsUser: 1000                          
        runAsGroup: 3000                         
        runAsNonRoot: true                       
        appArmorProfile:
            type: localhost/*
        localhostProfile: k8s-apparmor-example-deny-write       
        seccompProfile:                          
            type: RuntimeDefault                 
        privileged: false                        
        procMount: Default                       
        sysctls:                                 
          - name: net.ipv4.ip_local_port_range 
            value: "1024 65535"                
        seLinuxOptions:                          
            user: system_u                       
            role: system_r                       
            type: container_init_t                   
            level: s0 
    network:
        hostNetwork: true
        hostPID: false
        hostIPC: false
        hostPorts:
        - containerPort: 8081
          hostPort: 12345
          protocol: TCP        
          metadata:
              service: example-service
              type: master-node
              desc: for metrics of example-service
        - containerPort: 8080
          hostPort: 12346
          protocol: TCP        
          metadata:
              service: example-service
              type: master-node
              desc: for connetions to example-service
    volumes: 
        hostPath:
            - path: /var/logs
              type: Directory
              metadata:
                desc: For parsing logs                         
*/ -}}
{{- /* return securityContext */ -}}

{{- define "helm_lib_module_pss_settings" }}
{{- with .securityContext }}
securityContext:
  readOnlyRootFilesystem:{{ if hasKey . "readOnlyRootFilesystem" }} {{ .readOnlyRootFilesystem }}{{ else }} true{{ end }}
  allowPrivilegeEscalation:{{ if hasKey . "allowPrivilegeEscalation" }} {{ .allowPrivilegeEscalation }}{{ else }} false{{ end }}
  capabilities:
    drop:
      - all
    {{- if .capabilities.add }}
    add: 
      {{- .capabilities.add | toYaml | nindent 6 }}
    {{- end }}
  runAsUser: {{ .runAsUser | default 64535 }}
  runAsGroup: {{ .runAsGroup | default 64535 }}
  {{- if .fsGroup }}
  fsGroup: {{ .fsGroup }}
  {{- end }}
  runAsNonRoot:{{ if hasKey . "runAsNonRoot" }} {{ .runAsNonRoot }}{{ else }} true{{ end }}
  seccompProfile:
    type: {{ .seccompProfile.type | default "RuntimeDefault" }}
  {{- if .windowsOptions }}
    {{- if hasKey .windowsOptions "hostProcess" }}
  windowsOptions:
    hostProcess: {{ .windowsOptions.hostProcess }}
    {{- end }}
  {{- end }}
  {{- if hasKey . "privileged" }}
  privileged: {{ .privileged | default false }}
  {{- end }}
  procMount: {{ .procMount | default "Default" }}
  {{- if hasKey . "appArmorProfile" }}
    {{- if hasKey .appArmorProfile "type" }}
  appArmorProfile: 
    {{- .appArmorProfile | toYaml | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- if hasKey . "seLinuxOptions" }}
  seLinuxOptions:
    {{-  .seLinuxOptions | toYaml | nindent 4 }}
  {{- end }}
  {{- if .sysctls }}
  sysctls:
  {{- range .sysctls }}
    - name: {{ .name }}
      value: {{ .value }}
  {{- end }}
  {{- end }}
{{- end }}
{{- end }}


{{- /*  Auxiliary internal function */ -}}
{{- define "helm_lib_module_pss_generate_annotation" }}
  {{- $type := .type -}}
  {{- $param := .param -}}
  {{- $annotation_info := .annotation_info -}}
  {{- $helm_lib_module_pss_rules_table := fromYaml (include "helm_lib_module_pss_rules_table" .) -}}
  
  {{- if hasKey $helm_lib_module_pss_rules_table $type }}
    {{- $rulesForType := index $helm_lib_module_pss_rules_table $type -}}
    {{- if hasKey $rulesForType $param }}
      {{- $constraint := index $rulesForType $param -}}
      {{- if eq $param "hostPorts" -}}
        {{- $description := .metadata.desc }}
        {{- dict ( printf "security.deckhouse.io/skip-pss-check/%s/hostPort/%.0f" $constraint .portNumber ) $description  | toYaml }}
      {{- else if eq $param "hostPath" -}}
        {{- $description := .metadata.desc }}
        {{- dict ( printf "security.deckhouse.io/skip-pss-check/%s/hostPath/_%s_" $constraint .path ) $description  | toYaml }}
      {{- else }}
        {{- $description := index $annotation_info $type $param }}
        {{- dict ( printf "security.deckhouse.io/skip-pss-check/%s" $constraint ) $description  | toYaml }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}

{{- /*  Auxiliary internal function */ -}}
{{- define "helm_lib_module_pss_merge_annotations" }}
  {{- $output := dict }}
  {{- $annotation := fromYaml .annotation -}}
  {{- $annotations := fromYaml .annotations -}}
    {{- range $key, $value := $annotation -}}
      {{- if hasKey $annotations $key -}}
        {{- $output = set $annotations $key (printf "%s\n%s" (index $annotations $key) $value) -}}
      {{- else -}}
        {{- $output = set $annotations $key $value -}}
      {{- end -}}
    {{- end -}}
  {{- $output | toYaml -}}
{{- end }}


{{- /* Usage: {{- include "helm_lib_module_pss_annotations" ( dict "settings" $settings "annotation_info" $annotation_info ) | nindent 2 }} */ -}}
{{- /* settings example */ -}}
{{- /* 
settings:
    securityContext:                             
        readOnlyRootFilesystem: true             
        allowPrivilegeEscalation: false          
        capabilities:                            
            drop:                                
                - ALL                            
            add:
                - NET_BIND_SERVICE   
        runAsUser: 1000                          
        runAsGroup: 3000                         
        runAsNonRoot: true                       
        appArmorProfile:
            type: localhost/*
        localhostProfile: k8s-apparmor-example-deny-write       
        seccompProfile:                          
            type: RuntimeDefault                 
        privileged: false                        
        procMount: Default                       
        sysctls:                                 
          - name: net.ipv4.ip_local_port_range 
            value: "1024 65535"                
        seLinuxOptions:                          
            user: system_u                       
            role: system_r                       
            type: container_init_t                   
            level: s0 
    network:
        hostNetwork: true
        hostPID: false
        hostIPC: false
        hostPorts:
        - containerPort: 8081
          hostPort: 12345
          protocol: TCP        
          metadata:
              service: example-service
              type: master-node
              desc: for metrics of example-service
        - containerPort: 8080
          hostPort: 12346
          protocol: TCP        
          metadata:
              service: example-service
              type: master-node
              desc: for connetions to example-service
    volumes: 
        hostPath:
            - path: /var/logs
              type: Directory
              metadata:
                desc: For parsing logs                      
*/ -}}
{{- /* annotation_info example */ -}}
{{- /* 
annotation_info:
    securityContext:
        capabilities: |
            On some systems, the `timex` collector requires an additional capability `SYS_TIME`
            See https://github.com/prometheus/node_exporter/blob/v1.9.1/README.md?plain=1#L71
        runAsUser: |
            runAsUser.
            I added this field only for demonstration purposes.
        runAsNonRoot: |
            runAsNonRoot.
            I added this field only for demonstration purposes.
        allowPrivilegeEscalation: |
            allowPrivilegeEscalation.
            I added this field only for demonstration purposes.
        seccompProfile: |
            seccompProfile.
            I added this field only for demonstration purposes.
        windowsOptions: |
            windowsOptions.
            I added this field only for demonstration purposes.
        privileged: |
            privileged.
            I added this field only for demonstration purposes.
        procMount: |
            procMount.
            I added this field only for demonstration purposes.
        seLinuxOptions: |
            seLinuxOptions.
            I added this field only for demonstration purposes.
        sysctls: |
            sysctls.
            I added this field only for demonstration purposes.
        appArmorProfile: |
            appArmorProfile.
            I added this field only for demonstration purposes.
    network:
        hostNetwork: |
            hostNetwork.
            I added this field only for demonstration purposes.
        hostPID: |
            hostPID.
            I added this field only for demonstration purposes.
        hostIPC: |
            hostIPC.
            I added this field only for demonstration purposes.
                    
*/ -}}
{{- /* return annotations */ -}}

{{- define "helm_lib_module_pss_annotations" }}
{{- $annotation_info := .annotation_info -}}
{{- $annotations := "" -}}
{{- with .settings.securityContext }}
  {{- /* allowPrivilegeEscalation. Acceptable values: false, nd */ -}}
  {{- $allowPrivilegeEscalation := default false .allowPrivilegeEscalation -}}
  {{- if (ne $allowPrivilegeEscalation false) }}
    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "allowPrivilegeEscalation") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
  {{ end }}

  {{- /* Acceptable values for capabilities: */ -}}
  {{- $validCapabilities := list "NET_BIND_SERVICE" -}}
  {{- /* Проверка capabilities */ -}}
  {{- if (and .capabilities .capabilities.add) }}
    {{- range .capabilities.add }}
      {{- if not (has . $validCapabilities) }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "capabilities") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}      
      {{- end }}
    {{- end }}
  {{- end }}

  {{- /* runAsUser: only non-zero values ​​are allowed */ -}}
  {{- $runAsUser := default "" (quote .runAsUser) -}}
  {{- if eq $runAsUser (quote 0) }}
    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "runAsUser") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}      
  {{- end }}

  {{- /* runAsNonRoot. Acceptable values: true */ -}}
  {{- $runAsNonRoot := true -}}
  {{- if hasKey . "runAsNonRoot" }}
    {{- $runAsNonRoot = .runAsNonRoot }}
  {{- end }}
  {{- if (ne $runAsNonRoot true) }}

    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "runAsNonRoot") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
  {{- end }}

  {{- /* seccompProfile. Acceptable values: "RuntimeDefault" */ -}}
  {{- if (and .seccompProfile (ne (default "RuntimeDefault" .seccompProfile.type) "RuntimeDefault")) }}
    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "seccompProfile") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
  {{- end }}

  {{- /* privileged. Acceptable values: false, nd */ -}}
  {{- $privileged := false -}}
  {{- if hasKey . "privileged" }}
    {{- $privileged = .privileged }}
  {{- end }}
  {{- if (ne $privileged false) }}
    {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "privileged") }}
    {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
  {{- end }}

  {{- /* procMount. Acceptable values: "Default", nd */ -}}
  {{- if (ne (default "Default" .procMount) "Default") }}
    {{- include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "procMount") }}
  {{- end }}

  {{- /* seLinuxOptions */ -}}
  {{- if .seLinuxOptions }}
    {{- $selinuxType := default "" .seLinuxOptions.type -}}
    {{- $validSELinuxTypes := list "container_t" "container_init_t" "container_kvm_t" "container_engine_t" "" -}}
    {{- if (not (has $selinuxType $validSELinuxTypes)) }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "seLinuxOptions") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
    {{- end }}
  {{- end }}

  {{- /* appArmorProfile */ -}}
  {{- if .appArmorProfile }}
    {{- $appArmorProfileType := default "" .appArmorProfile.type -}}
    {{- $validappArmorProfileTypes := list "runtime/default" "localhost/*" "" -}}
    {{- if (not (has $appArmorProfileType $validappArmorProfileTypes)) }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "appArmorProfile") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
    {{- end }}
  {{- end }}

  {{- /* sysctls */ -}}
  {{- if .sysctls }}
    {{- $isAnnotationNeeded := false -}}
    {{- $allowedSysctls := list "kernel.shm_rmid_forced" "net.ipv4.ip_local_port_range" "net.ipv4.ip_unprivileged_port_start" "net.ipv4.tcp_syncookies" "net.ipv4.ping_group_range" "net.ipv4.ip_local_reserved_ports" "net.ipv4.tcp_keepalive_time" "net.ipv4.tcp_fin_timeout" "net.ipv4.tcp_keepalive_intvl" "net.ipv4.tcp_keepalive_probes" -}}
    {{- range .sysctls }}
      {{- if (and .name (not (has .name $allowedSysctls))) }}
        {{- $isAnnotationNeeded = true }}
      {{- end }}
    {{- end }}
    {{- if $isAnnotationNeeded }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "securityContext" "param" "sysctls") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}    
    {{- end }}
  {{- end }}
{{- end }}
{{- with .settings.network }}
  {{- if .hostNetwork }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "network" "param" "hostNetwork") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
  {{- end }}
  {{- if .hostPID }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "network" "param" "hostPID") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
  {{- end }}
  {{- if .hostIPC }}
      {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "network" "param" "hostIPC") }}
      {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
  {{- end }}
  {{- if .hostPorts }}
      {{- range .hostPorts }}
        {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "network" "param" "hostPorts" "portNumber" .hostPort "metadata" .metadata) }}
        {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
      {{- end }}
  {{- end }}
{{- end }}
{{- with .settings.volumes }}
  {{- if .hostPath }}
      {{- range .hostPath }}
        {{- $annotation := include "helm_lib_module_pss_generate_annotation" (dict "annotation_info" $annotation_info "type" "volumes" "param" "hostPath" "path" .path "metadata" .metadata) }}
        {{- $annotations = include "helm_lib_module_pss_merge_annotations" (dict "annotation" $annotation "annotations" $annotations)  -}}
      {{- end }}
  {{- end }}
{{- end }}

{{ $annotations  }}   
{{- end }}

