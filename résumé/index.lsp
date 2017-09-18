(html ([lang "en"])
  (head
    (meta ([charset "utf-8"]))
    (meta ([http-equiv "X-UA-Compatible"]
           [content    "IE=edge"]))
    (meta ([name "viewport"]
           [content "width=device-width, initial-scale=1"]))
    (title "Résumé — Fengyang Wang")
    ;; Page style
    (link ([rel     "stylesheet"]
           [href    "/css/main.css"]
           [media   "screen"]
           [title   "master"]
           [charset "utf-8"]))
    (script (include "ga.js" #:text)))
  (body
    (header ([vocal  "http://schema.org/"]
             [typeof "Person"])
      (h1 ([property "name"]) "Fengyang Wang")
      (address
        (ul (li ([property "affiliation"]) "University of Waterloo")
            (li ([property "email"])
              (a ([href "mailto:fengyang.wang@uwaterloo.ca"])
                "fengyang.wang@uwaterloo.ca"))
            (li ([property "mainEntityOfPage"])
              (a ([href "//wafy.me"]) "wafy.me"))
            (li ([data-property "github"])
              (a ([href "https://github.com/TotalVerb/"]) "TotalVerb")))))
    (main
      (section
        (h1 "Summary of Qualifications")
        (ul (li "Software developer with C, C++, and Python experience")
            (li "Strong problem solver with high school and university level
                 competition participation")
            (li "Effective communicator developed through three years as
                 mathematics instructor")))
      (section
        (h1 "Experience")
        (section ([class "work-experience"])
          (h1 "Software Developer Intern")
          (address (a ([href "https://www.bloomberg.com/"]) "Bloomberg LP"))
          (time 2016)
          (ul (li "Developed an event processing system with Scala and Apache "
                  "Storm")
              (li "Ensured scalability and reproducibility using Chef")
              (li "Designed UI and database for new system")))
        (section ([class "work-experience"])
          (h1 "Olympic Math Teacher")
          (address (a ([href "http://grandriverchineseschool.com/aboutus.htm"])
                     "Grand River Chinese School"))
          (time "2012–present")
          (ul (li "Created an innovative 22-lesson "
                  (a ([href "https://github.com/TotalVerb/math-grade4"])
                    "mathematics curriculum")
                  " for Grade 4 students")
              (li "Taught for two years after one year of being a teaching assistant")
              (li "Increased class size from 9 to 19 over two years"))))
      (section
        (h1 "Education")
        (section ([class "work-experience"])
          (h1 "Bachelor of Mathematics")
          (address (a ([href "https://www.uwaterloo.ca"]) "University of Waterloo"))
          (time "2015–present")
          (ul (li "Winner of " (q "Réné Descartes National Scholarship")
                  ", awarded by University of Waterloo ($25000 value)")
              (li "Term Dean’s Honours for Fall 2015, Winter 2016, Fall
                   2016"))))
      (section
        (h1 "Projects")
        (section ([class "work-experience"])
          (h1 "Currencies.jl")
          (address (a ([href "https://github.com/JuliaFinance/Currencies.jl"])
                     "GitHub"))
          (time "2015–present")
          (ul (li "Currency arithmetic, conversion, and format library")
              (li "Written in Julia")))
        (section ([class "work-experience"])
          (h1 "Liquid")
          (address (a ([href "//wafy.me/liquid"]) "wafy.me"))
          (time 2015)
          (ul (li "Simple territorial board game")
              (li "Javascript and HTML technologies")
              (li "Used " (a ([href "http://www.fabricjs.com/"]) "fabric.js")
                  " drawing library")))
        (p "For more projects, please see my "
           (a ([href "/projects"]) "projects")
           " page."))
      (section
        (h1 "Achievements")
        (section ([class "work-experience"])
          (h1 "Putnam Math Competition")
          (address (a ([href "http://math.scu.edu/putnam/"])
                     "Mathematical Association of America"))
          (time 2015)
          (ul (li "Placed in top 200 across Canada and United States")))
        (section ([class "work-experience"])
          (h1 "Canadian Mathematical Olympiad")
          (address (a ([href "http://cms.math.ca/"])
                     "Canadian Mathematical Society"))
          (time "2014, 2015")
          (ul (li "Finished in top 40 nationwide (both years)")))
        (section ([class "work-experience"])
          (h1 "Canadian Computing Olympiad")
          (address (a ([href "http://www.cemc.uwaterloo.ca/contests/past_contests/2014/2014CCCStage2Results.pdf"])
                     "Centre for Education in Mathematics and Computing"))
          (time 2014)
          (ul (li "Received Silver Medal"))))
      (section
        (h1 "Skills")
        (section ([class "skills-list"])
          (h1 "Programming Languages")
          (ul (li "C")
              (li "C++")
              (li "Java")
              (li "Python")
              (li "JavaScript")
              (li "Julia")
              (li "Scheme")))
        (section ([class "skills-list"])
          (h1 "Technologies")
          (ul (li "HTML")
              (li "CSS")
              (li "(La)TeX")
              (li "Git")))))
    (footer ([vocab  "http://schema.org/"]
             [typeof "Person"])
      (p "This résumé available in an alternative "
         (a ([href "typeset.pdf"]) "typeset format")
         " and an alternative "
         (a ([href "index.lsp"]) "lispy format."))
      (address
        (ul (li ([property "name"]) "Fengyang Wang")
            (li ([property "email"])
              (a ([href "mailto:fengyang.wang@uwaterloo.ca"])
                "fengyang.wang@uwaterloo.ca"))
            (li ([property "mainEntityOfPage"])
              (a ([href "//wafy.me"]) "wafy.me"))
            (li ([data-property "github"])
              (a ([href "https://github.com/TotalVerb/"]) "TotalVerb")))))))
