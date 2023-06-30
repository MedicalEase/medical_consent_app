vids = [
    "ALL1.1_COLLECTION_REPLAY.mov",
    "ALL4C_FINISHED_INFO_NEEDED.mov",
    "FAQ4_COLLECTION.mov",
    "FLEXI2_SEDATION.mov",
    "OGDCOLON2_SEDATION.mov",
    "ALL1_COLLECTION.mov",
    "COLON1_INTRO.mov",
    "FAQ5.1_24HOURS.mov",
    "FLEXI3_RISKS.mov",
    "OGDCOLON3_RISKS.mov",
    "ALL2.1_24HOURS_REPLAY.mov",
    "COLON2_SEDATION.mov",
    "FAQ5_24HOURS.mov",
    "OGD1_INTRO.mov",
    "OGDFLEXI1_1INTRO.mov",
    "ALL2_24HOURS.mov",
    "FAQ1_GENERAL.mov",
    "FAQ6.1_FLEXI_COLON_RISKS.mov",
    "OGD2_THROAT_SPRAY.mov",
    "OGDFLEXI2_SEDATION.mov",
    "ALL3_PROCEED.mov",
    "FAQ2_THROAT_SPRAY.mov",
    "FAQ6.2_COMBINED_RISKS.mov",
    "OGD3_SEDATION.mov",
    "OGDFLEXI3_RISKS.mov",
    "ALL4A_FINISHED_CONSENT.mov",
    "FAQ3_SEDATION.mov",
    "FAQ6_OGD_RISKS.mov",
    "OGD4_RISKS.mov",
    "OGDFLEXI4_PROCEED.mov",
    "ALL4B_FINISHED_NOT_CONSENTING.mov",
    "FAQ4.1_COLLECTION.mov",
    "FLEXI1_INTRO.mov",
    "OGDCOLON1_INTRO.mov",
]

import os
import shutil


def navigate_and_rename():
    for item in vids:
        shutil.copy("_placeholder.mov",
                    os.path.join('.', item))


navigate_and_rename()
