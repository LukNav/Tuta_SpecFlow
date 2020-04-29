using System;
using TechTalk.SpecFlow;
using Newtonsoft.Json;
using NUnit.Framework;
using System.Net.Http;
using TUTA_specflow.Entities.JsonObjects;

namespace TUTA_specflow.Steps
{
    [Binding]
    public class ReqresTestSteps
    {
        public static HttpClient HttpClient { get; private set; }
        public static HttpRequestMessage HttpRequestMessage { get; private set; }
        public static HttpResponseMessage HttpResponseMessage { get; private set; }
        internal static reqresObject ReqresResult { get => ReqresResult; set => ReqresResult = value; }

        private static reqresObject reqresResult = new reqresObject() { };

        private static string _reqresUri;

        private int responseCodeValue;

        public static void SwapOutHttpClient(HttpClient client)
        {
            HttpClient = client;
        }

        [BeforeScenario]
        public void Before()
        {
            if (HttpClient == null)
                HttpClient = new HttpClient();

            if (HttpRequestMessage == null)
                HttpRequestMessage = new HttpRequestMessage();
        }


        [Given(@"I am using the base url as '(.*)'")]
        public void GivenIAmUsingTheBaseUrlAs(string baseURL)
        {
            if (HttpClient.BaseAddress == null)
            {
                HttpClient.BaseAddress = new Uri(baseURL);
            }
        }

        [Given(@"I setup the request to GET using the provided '(.*)' as value")]
        public void GivenISetupTheRequestToGETUsingTheProvidedAsValue(string ID)
        {
            HttpRequestMessage = new HttpRequestMessage();
            HttpRequestMessage.Method = new HttpMethod("Get");
            _reqresUri = ID;
        }

        [When(@"I send the request through")]
        public void WhenISendTheRequestThrough()
        {
            HttpRequestMessage.RequestUri = new Uri(_reqresUri, UriKind.Relative);
            HttpResponseMessage = HttpClient.SendAsync(HttpRequestMessage).Result;
        }

        [Then(@"I should receive a response back")]
        public void ThenIShouldReceiveAResponseBack()
        {
            string json = @"" + HttpResponseMessage.Content.ReadAsStringAsync().Result + "";

            reqresResult = JsonConvert.DeserializeObject<reqresObject>(json);
        }

        [Then(@"I should have received a status code of (.*)")]
        public void ThenIShouldHaveReceivedAStatusCodeOf(int responseCode)
        {
            responseCodeValue = responseCode;

            Assert.That((int)HttpResponseMessage.StatusCode, Is.EqualTo(responseCodeValue));
        }

        [Then(@"I validate first_name should have '(.*)' value")]
        public void ThenIValidateFirst_NameShouldHaveValue(string first_name)
        {
            Assert.That(reqresResult.data.first_name == first_name);
        }

        [Then(@"I validate last_name should have '(.*)' value")]
        public void ThenIValidateLast_NameShouldHaveValue(string last_name)
        {
            Assert.That(reqresResult.data.last_name == last_name);
        }




    }
}