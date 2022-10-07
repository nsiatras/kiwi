package isocountriesgenerator;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Locale;

/**
 *
 * @author Nikos Siatras
 */
public class ISOCountriesGenerator
{

    public static void main(String[] args)
    {
        ArrayList<String> result = new ArrayList<String>();
        String[] countryCodes = Locale.getISOCountries();

        for (String countryCode : countryCodes)
        {
            Locale locale = new Locale("", countryCode);
            try
            {
                String countryName = locale.getDisplayCountry();
                String countryISO = locale.getISO3Country();
                //String countryLanguage = locale.getDisplayLanguage();
                result.add("Locale.fISOCountriesList.add(Country(\"" + countryName + "\", " + "\"" + countryISO + "\"" + ")");
            }
            catch (Exception ex)
            {

            }
        }

        // Sort the result
        result.sort(new Comparator<String>()
        {
            @Override
            public int compare(String o1, String o2)
            {
                return o1.compareTo(o2);
            }
        });

        //System.out.println("Dim result as ArrayList(Country)");
        int i = 0;
        for (String s : result)
        {
            System.out.println(s);
        }
    }

}
