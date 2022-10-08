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

    /**
     * The following code generates the result ArrayList of
     * Locale.getISOCountries() of Locale UDT object of Kiwi located in
     * kiwi/locale/Locale.bi
     *
     * @param args
     */
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
                String countryISO3 = locale.getISO3Country();

                String tmp = "Locale.fISOCountriesList.add(Country(#name#, #iso#, #iso3#))";
                tmp = tmp.replace("#name#", "\"" + countryName + "\"");
                tmp = tmp.replace("#iso#", "\"" + countryCode + "\"");
                tmp = tmp.replace("#iso3#", "\"" + countryISO3 + "\"");

                result.add(tmp);
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

        for (String s : result)
        {
            System.out.println(s);
        }
    }

}
